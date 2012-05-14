-- /*******************************************************************
--  Test scripts for ITA_SPE_551, Support four new RTP dashlet.
--  
--  The insertion order matters, should follow the order defined 
--  in /ua-db/dbInstall/sqlldr/itaowner.tables.lst
-- *******************************************************************/

-- 1. table DASHBOARD_FILTER, add x records
-- Reserved 
-- INSERT INTO DASHBOARD_FILTER (id, from_time, to_time)
-- VALUES() 

-- 2. table DASHBOARD, add x records
-- Reserved 
-- INSERT INTO DASHBOARD (id, classification, custom_drill, filtertype, owner, title, dashtype, filter_id)
-- VALUES() 

-- 3. table METAKPI, add 3 records
INSERT INTO METAKPI (id, name) VALUES (463, 'rtp_all');
INSERT INTO METAKPI (id, name) VALUES (464, 'rtp_audio');
INSERT INTO METAKPI (id, name) VALUES (465, 'rtp_video');

-- 4. table METAKPIGROUP, add 2 records
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_JITTER_TIME_NUM', 'Jitter Count and Time Stats for RTP', 4); 
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_PACKET_PERCENTAGE', 'Jitter Percentage Stats for RTP', 3);

-- 5. table KPICHOICE, add 6 records
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_ALL_APP_DETAIL', 'All RTP traffic for App Detail', 'rtp_all', 'RTP_JITTER_TIME_NUM', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_AUDIO_APP_DETAIL', 'Audio RTP traffic for App Detail', 'rtp_audio', 'RTP_JITTER_TIME_NUM', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_VIDEO_APP_DETAIL', 'Video RTP traffic for App Detail', 'rtp_video', 'RTP_JITTER_TIME_NUM', 465);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_ALL_APP_SUMMARY', 'All RTP traffic for App Summary', 'rtp_all', 'RTP_PACKET_PERCENTAGE', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_AUDIO_APP_SUMMARY', 'Audio RTP traffic for App Summary', 'rtp_audio', 'RTP_PACKET_PERCENTAGE', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_VIDEO_APP_SUMMARY', 'Video RTP traffic for App Summary', 'rtp_video', 'RTP_PACKET_PERCENTAGE', 465);

-- 6. table IRISCONTENT, add 4 records
-- In pl/sql developer, This part may be considered as containing variables because the character & has special meanings.
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (64, 'APPLICATION', '/ita/topn/jitterdetail?dimType=APPLICATION&binType=jitterTime', 1, 1, 'COLUMNLINEBAR', 'RTP_ALL_APP_DETAIL');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (65, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=loss_packet', 1, 1, 'PERCENTAGE', 'RTP_ALL_APP_SUMMARY');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (66, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=dup_packet', 1, 1, 'PERCENTAGE', 'RTP_ALL_APP_SUMMARY');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (67, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=oos_packet', 1, 1, 'PERCENTAGE', 'RTP_ALL_APP_SUMMARY');

-- 7. table DASHLET, add 4 records
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (64, 300, 1, 'app-detail-jitter', 0, 'Average Jitter Number', 940, 0, 1240, 64);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (65, 300, 1, 'app-detail-loss-packet', 0, 'Packet loss', 465, 0, 1550, 65);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (66, 300, 1, 'app-detail-duplicate-packet', 0, 'Duplicate Packet', 465, 475, 1550, 66);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (67, 300, 1, 'app-detail-out-of-sequence-packet', 0, 'Out of sequence Packet', 465, 0, 1860, 67);

-- 8. table DASHBOARD_DASHLET, add 4 records 
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 64);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 65);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 66);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 67);

-- 9. table IRISCONTENT_KPICHOICE, add 12 records
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_ALL_APP_DETAIL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_AUDIO_APP_DETAIL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_VIDEO_APP_DETAIL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_ALL_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_AUDIO_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_VIDEO_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_ALL_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_AUDIO_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_VIDEO_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_ALL_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_AUDIO_APP_SUMMARY');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_VIDEO_APP_SUMMARY');

-- 10. table IRISDRILL, add x records
-- Reserved 
-- INSERT INTO IRISDRILL (id, from_dim)
-- VALUES()

-- 11. table IRISDRILL_DASHBOARD, add x records
-- Reserved 
-- INSERT INTO IRISDRILL_DASHBOARD (irisdrill_id, toDetailPages_id)
-- VALUES()

-- 12. table KPICHOICE_TO_METAKPI, add 6 records
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_ALL_APP_DETAIL', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_AUDIO_APP_DETAIL', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_VIDEO_APP_DETAIL', 465, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_ALL_APP_SUMMARY', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_AUDIO_APP_SUMMARY', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_VIDEO_APP_SUMMARY', 465, 1);

-- 13. table KPIGROUP_TO_METAKPI, add 6 records 
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 465, 3);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_PERCENTAGE', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_PERCENTAGE', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_PERCENTAGE', 465, 3);

-- 14. table META_KPI_QUERY, add 2 records
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (62, 'RTP_JITTER_TIME_NUM', 'rtpCodecType,bin1,bin2,bin3,bin4,bin5,binTotal,timeStamp', 'LONG,LONG,LONG,LONG,LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(rtp_jitter_bin1) as bin1,sum(rtp_jitter_bin2) as bin2,sum(rtp_jitter_bin3) as bin3,sum(rtp_jitter_bin4) as bin4,sum(rtp_jitter_bin5) as bin5,sum(rtp_jitter_total) as binTotal,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpJitterSummary', '');
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (63, 'RTP_PACKET_PERCENTAGE', 'rtpCodecType,targetPacket,num_packets,timeStamp', 'LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(target_field) as targetPacket,sum(rtp_total_packet) as num_packets,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpPacketSummary', '');
