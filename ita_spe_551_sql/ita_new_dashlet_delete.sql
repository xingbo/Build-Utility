-- /*******************************************************************
--  Test scripts for ITA_SPE_551, Support four new RTP dashlet.
--  
--  Revert all the changes made in SP2
-- *******************************************************************/

delete from META_KPI_QUERY where id=62;
delete from META_KPI_QUERY where id=63;
delete from META_KPI_QUERY where id=64;
delete from META_KPI_QUERY where id=65;

delete from KPIGROUP_TO_METAKPI where group_id='RTP_JITTER_TIME_NUM' and kpi_position=1;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_JITTER_TIME_NUM' and kpi_position=2;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_JITTER_TIME_NUM' and kpi_position=3;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_LOSS_PERCENTAGE' and kpi_position=1;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_LOSS_PERCENTAGE' and kpi_position=2;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_LOSS_PERCENTAGE' and kpi_position=3;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_DUP_PERCENTAGE' and kpi_position=1;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_DUP_PERCENTAGE' and kpi_position=2;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_DUP_PERCENTAGE' and kpi_position=3;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_OOS_PERCENTAGE' and kpi_position=1;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_OOS_PERCENTAGE' and kpi_position=2;
delete from KPIGROUP_TO_METAKPI where group_id='RTP_PACKET_OOS_PERCENTAGE' and kpi_position=3;

delete from KPICHOICE_TO_METAKPI where choice_id='RTP_JITTER_ALL' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_JITTER_AUDIO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_JITTER_VIDEO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_LOSS_ALL' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_LOSS_AUDIO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_LOSS_VIDEO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_DUP_ALL' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_DUP_AUDIO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_DUP_VIDEO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_OOS_ALL' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_OOS_AUDIO' and kpi_position=1;
delete from KPICHOICE_TO_METAKPI where choice_id='RTP_PACKET_OOS_VIDEO' and kpi_position=1;

delete from IRISCONTENT_KPICHOICE where iriscontent_id=64 and kpiChoices_name='RTP_JITTER_ALL';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=64 and kpiChoices_name='RTP_JITTER_AUDIO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=64 and kpiChoices_name='RTP_JITTER_VIDEO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=65 and kpiChoices_name='RTP_PACKET_LOSS_ALL';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=65 and kpiChoices_name='RTP_PACKET_LOSS_AUDIO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=65 and kpiChoices_name='RTP_PACKET_LOSS_VIDEO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=66 and kpiChoices_name='RTP_PACKET_DUP_ALL';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=66 and kpiChoices_name='RTP_PACKET_DUP_AUDIO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=66 and kpiChoices_name='RTP_PACKET_DUP_VIDEO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=67 and kpiChoices_name='RTP_PACKET_OOS_ALL';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=67 and kpiChoices_name='RTP_PACKET_OOS_AUDIO';
delete from IRISCONTENT_KPICHOICE where iriscontent_id=67 and kpiChoices_name='RTP_PACKET_OOS_VIDEO';

delete from DASHBOARD_DASHLET where dashboard_id=7 and dashlets_id=64;
delete from DASHBOARD_DASHLET where dashboard_id=7 and dashlets_id=65;
delete from DASHBOARD_DASHLET where dashboard_id=7 and dashlets_id=66;
delete from DASHBOARD_DASHLET where dashboard_id=7 and dashlets_id=67;

delete from dashlet where id=64;
delete from dashlet where id=65;
delete from dashlet where id=66;
delete from dashlet where id=67;

delete from iriscontent where id=64;
delete from iriscontent where id=65;
delete from iriscontent where id=66;
delete from iriscontent where id=67;

delete from kpichoice where name='RTP_JITTER_ALL';
delete from kpichoice where name='RTP_JITTER_AUDIO';
delete from kpichoice where name='RTP_JITTER_VIDEO';
delete from kpichoice where name='RTP_PACKET_LOSS_ALL';
delete from kpichoice where name='RTP_PACKET_LOSS_AUDIO';
delete from kpichoice where name='RTP_PACKET_LOSS_VIDEO';
delete from kpichoice where name='RTP_PACKET_DUP_ALL';
delete from kpichoice where name='RTP_PACKET_DUP_AUDIO';
delete from kpichoice where name='RTP_PACKET_DUP_VIDEO';
delete from kpichoice where name='RTP_PACKET_OOS_ALL';
delete from kpichoice where name='RTP_PACKET_OOS_AUDIO';
delete from kpichoice where name='RTP_PACKET_OOS_VIDEO';

delete from METAKPIGROUP where name='RTP_JITTER_TIME_NUM';
delete from METAKPIGROUP where name='RTP_PACKET_LOSS_PERCENTAGE';
delete from METAKPIGROUP where name='RTP_PACKET_DUP_PERCENTAGE';
delete from METAKPIGROUP where name='RTP_PACKET_OOS_PERCENTAGE';

delete from METAKPI where id=463;
delete from METAKPI where id=464;
delete from METAKPI where id=465;



