@echo off
:: Enable delayed variable expansion
SETLOCAL ENABLEDELAYEDEXPANSION

:: Set the global environment
set JAVA_HOME=C:\java\jdk1.6
set GRAILS11_HOME=C:\grails-1.1.1
set GRAILS13_HOME=C:\grails-1.3.5
set M2_HOME=C:\maven-3.0.3
set PROTOC_PATH=D:\testGrials\protobuf\protobuf-2.3.0\protoc.exe
set MAVEN_OPTS=-Xmx512m -XX:MaxPermSize=256m

call :getUserHome USER_HOME
set GRAILS_PLUGIN_HOME=%USER_HOME%\.grails\1.1.1
set GRAILS_HOME=!GRAILS11_HOME!
set VERSION=DEV_SPE_551_SP1-SNAPSHOT

:: Prepare the common varibles
set BASE_DIR=%cd%
if NOT "%BASE_DIR:~-6%"=="server" echo The build.bat should be run inside [server] folder & goto eof: 
set MVN_SETTINGS=%BASE_DIR%\settings.xml
set MVN_CMD=%M2_HOME%\bin\mvn.bat -s %MVN_SETTINGS%
set GRAILS_CMD=!GRAILS_HOME!\bin\grails.bat 

:: Print help usage info
set TEST_OPTS=-Dmaven.test.skip=true
if "%1"=="-h" (
    echo. 
    echo  Usage: build.bat [-wt] [options] [target]
    echo    -wt     :   enable maven test
    echo  options:
    echo    -e      :   maven parameters, to show error log
    echo    -X      :   maven parameters, to show detail debug log
    echo    target  :   targets, "omit" will compile the whole project; "clean" will clean the whole project
    goto :eof
)

:: clean up the whole poject, usually used before commit to trunk
for %%p in (%*) do (
    if %%p==clean (
        echo.
        echo ===== CLEAN UP THE WHOLE PROJECT =====
        echo.
        call %MVN_CMD% -f parent-gen-pom.xml clean 
        call %MVN_CMD% -f plist-package-pom.xml clean 
        call %MVN_CMD% -f gpb-gen-pom.xml clean 
        call %MVN_CMD% clean 
        goto :eof
    )
)

if "%1"=="-wt" (
    echo.
    echo ===== BUILD WHOLE PROJECT WITH ALL TEST ENABLED =====
    echo.
    shift /1
    set TEST_OPTS=
)

:: Step.0 Compile 
call :printHead CompileParentModule
call %MVN_CMD% -f parent-gen-pom.xml clean install %1
if errorlevel 1 (
    echo    #### Compile Failure ####
    goto :eof 
)


:: Step.1 Compile the "common" folder
call :printHead CompileCommonModule
call %MVN_CMD% -f plist-package-pom.xml clean install %1  
if errorlevel 1 (
    echo    #### Compile Failure ####
    goto :eof 
)


:: Step.2 Generate the java file for protoc files
call :printHead GenerateJavaGPBClass
call %MVN_CMD% -f gpb-gen-pom.xml clean install %1
if errorlevel 1 (
    echo    #### Compile Failure ####
    goto :eof 
)


:: Step.3. Compile the whole "server" folder
call :printHead CompileIrisProject
call %MVN_CMD% %TEST_OPTS% clean install %1
if errorlevel 1 (
   echo    #### Compile Failure ####
   goto :eof 
)


:: Step.4 Build Grails plugins
call :printHead GrailsPlugins
:: todo: call %MVN_CMD% -f %BASE_DIR%/grails-pom.xml package
call %MVN_CMD% -f %BASE_DIR%/grails/plugins/grailsDoctor/pom.xml process-resources


:: Step.4.1 Install "Grails Doctor" plugin
call :printHead grailsDoctor
cd %BASE_DIR%/grails/plugins/grailsDoctor
call %GRAILS_CMD% clean
call %GRAILS_CMD% package-plugin
call %GRAILS_CMD% install-plugin %BASE_DIR%/grails/plugins/grailsDoctor/grails-grails-doctor-1.3.zip -global --non-interactive
cd %BASE_DIR%


:: Step.4.2 Install "IRIS Licensing" plugin
call :printHead irisLicensingPlugin
cd %BASE_DIR%/grails/plugins/irisLicensingPlugin
call %GRAILS13_CMD% set-version %VERSION%
call %GRAILS_CMD% lib-doctor  
call %GRAILS_CMD% package-plugin-with-move 
call %MVN_CMD% -f %BASE_DIR%/grails/plugins/irisLicensingPlugin/plugin-install-pom.xml install
cd %BASE_DIR%


:: Step.4.3 Install "ivDash" plugin
call :printHead ivDash
cd %BASE_DIR%/grails/plugins/ivdash
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir ivDash
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.4.4 Install "irisComet" plugin
call :printHead irisComet
cd %BASE_DIR%/grails/plugins/irisComet
call %GRAILS_CMD% lib-doctor
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.4.5 Install "irisOamHelp" plugin
call :printHead irisOamHelp
cd %BASE_DIR%/grails/plugins/help/oamHelp
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.4.6 Install "irisUumsHelp" plugin
call :printHead irisUumsHelp
cd %BASE_DIR%/grails/plugins/help/uumsHelp
set GRAILS_HOME=!GRAILS13_HOME!
set GRAILS_CMD=!GRAILS_HOME!/bin/grails.bat
call %GRAILS13_CMD% package-plugin
call %MVN_CMD% -f %BASE_DIR%/grails/plugins/help/uumsHelp/plugin-install-pom.xml install
set GRAILS_HOME=!GRAILS11_HOME!
set GRAILS_CMD=!GRAILS_HOME!/bin/grails.bat
cd %BASE_DIR%


:: Step.4.7 Install "irisOAMUtil" plugin
call :printHead irisOAMUtil
cd %BASE_DIR%/grails/plugins/irisOamUtil
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir irisOAMUtil
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.4.8 Install "iqmodel" plugin
call :printHead iqmodel
cd %BASE_DIR%/grails/plugins/iqmodel
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir iqmodel
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.4.9 Install "uaKeyCache" plugin
call :printHead uaKeyCache
cd %BASE_DIR%/irisPI/common/uaKeyCache
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir uaKeyCache
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% package-plugin-with-move
call %MVN_CMD% -f %BASE_DIR%/irisPI/common/uaKeyCache/plugin-install-pom.xml install
cd %BASE_DIR%

:: Step.4.10 Install "logKiller" plugin
call :printHead logKiller
cd %BASE_DIR%/grails/plugins/logDbKill
call %GRAILS_CMD% package-plugin-with-move
cd %BASE_DIR%


:: Step.5 Build irisOAMWeb
call :printHead irisOAMWeb
cd %BASE_DIR%/irisOAM/irisOAMWeb
call %GRAILS_CMD% clean
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir irisOAMWeb
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% war
cd %BASE_DIR%


:: Step.6 Build irisDash
call :printHead irisDash
cd %BASE_DIR%/irisDash
call %GRAILS_CMD% clean
call %GRAILS_CMD% mvn-plug-pull
call %GRAILS_CMD% lib-doctor
call :delpluginDir irisDash
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% war
cd %BASE_DIR%


:: Step.7 Build irisPolicyWeb
call :printHead irisPolicyWeb
cd %BASE_DIR%/irisAlarms/irisPolicyWeb
call %GRAILS_CMD% lib-doctor
call %GRAILS_CMD% mvn-plug-pull
call :delpluginDir irisPolicyWeb
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% war
cd %BASE_DIR%


:: Step.8 Build irisRootWeb
call :printHead irisRootWeb
cd %BASE_DIR%/irisRootWeb
call %GRAILS_CMD% lib-doctor
call %GRAILS_CMD% mvn-plug-pull
call :delpluginDir irisRootWeb
call %GRAILS_CMD% bulk-plug-install
call %GRAILS_CMD% war
cd %BASE_DIR%


goto :eof



:: Subroutine.1 Print title for each step
:printHead
echo.
echo  ========================================
echo    Build Module: %1                                 
echo  ========================================
echo.
goto :eof


:: Subroutine.2 TRICK next step can't perform the delete operation successfully
:delpluginDir
set pluginDir=%GRAILS_PLUGIN_HOME%\projects\%1\plugins
if exist %pluginDir% (
    echo.
    echo %pluginDir%
    echo.
    rd /s /q %pluginDir%
)
goto :eof


:: Subroutine.3 TRICK get current user document directory
:getUserHome
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" > %Temp%\Tmp.x
FOR /F "TOKENS=2* DELIMS= " %%I IN ('TYPE %Temp%\Tmp.x^|FINDSTR /I "Desktop"') DO ( SET "Desktop=%%~J" )
ERASE %Temp%\Tmp.x
set %1=%Desktop:~0,-8%
goto :eof


:: Subroutine.4 Check whether last module is executed successfully or not
:checkResult
if /I NOT "%1"=="1" (
    echo.
    echo  ========================================
    echo           Compile Failure!!                                 
    echo  ========================================
    echo.
    goto :eof
)


:: Disable delayed variable expansion
ENDLOCAL


:eof

