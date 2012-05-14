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

-- 4. table METAKPIGROUP, add 4 records
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_JITTER_TIME_NUM', 'Jitter Count and Time Stats for RTP', 4); 
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_PACKET_LOSS_PERCENTAGE', 'RTP Percentage Stats for packet loss', 3);
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_PACKET_DUP_PERCENTAGE', 'RTP Percentage Stats for duplicate packet', 3);
INSERT INTO METAKPIGROUP (name, description, type)
VALUES ('RTP_PACKET_OOS_PERCENTAGE', 'RTP Percentage Stats for out of sequence packet', 3);

-- 5. table KPICHOICE, add 12 records
-- for jitter dashlet
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_JITTER_ALL', 'All Jitter RTP traffic count and time', 'rtp_all', 'RTP_JITTER_TIME_NUM', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_JITTER_AUDIO', 'Audio Jitter RTP traffic count and time', 'rtp_audio', 'RTP_JITTER_TIME_NUM', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_JITTER_VIDEO', 'Video Jitter RTP traffic count and time', 'rtp_video', 'RTP_JITTER_TIME_NUM', 465);
-- for packet loss dashlet
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_LOSS_ALL', 'All RTP traffic for loss packet', 'rtp_all', 'RTP_PACKET_LOSS_PERCENTAGE', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_LOSS_AUDIO', 'Audio RTP traffic for loss packet', 'rtp_audio', 'RTP_PACKET_LOSS_PERCENTAGE', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_LOSS_VIDEO', 'Video RTP traffic for loss packet', 'rtp_video', 'RTP_PACKET_LOSS_PERCENTAGE', 465);
-- for duplicate packet dashlet
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_DUP_ALL', 'All RTP traffic for duplicate packet', 'rtp_all', 'RTP_PACKET_DUP_PERCENTAGE', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_DUP_AUDIO', 'Audio RTP traffic for duplicate packet', 'rtp_audio', 'RTP_PACKET_DUP_PERCENTAGE', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_DUP_VIDEO', 'Video RTP traffic for duplicate packet', 'rtp_video', 'RTP_PACKET_DUP_PERCENTAGE', 465);
-- for out of sequence packet dashlet
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_OOS_ALL', 'All RTP traffic for out of sequence packet', 'rtp_all', 'RTP_PACKET_OOS_PERCENTAGE', 463);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_OOS_AUDIO', 'Audio RTP traffic for out of sequence packet', 'rtp_audio', 'RTP_PACKET_OOS_PERCENTAGE', 464);
INSERT INTO KPICHOICE (name, description, displayNameKey, KPI_GROUP_ID, SORT_KPI)
VALUES ('RTP_PACKET_OOS_VIDEO', 'Video RTP traffic for out of sequence packet', 'rtp_video', 'RTP_PACKET_OOS_PERCENTAGE', 465);

-- 6. table IRISCONTENT, add 4 records
-- In pl/sql developer, This part may be considered as containing variables because the character & has special meanings.
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (64, 'APPLICATION', '/ita/topn/jitterdetail?dimType=APPLICATION&binType=jitterTime', 1, 1, 'COLUMNLINEBAR', 'RTP_JITTER_ALL');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (65, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=loss_packet', 1, 1, 'PERCENTAGE', 'RTP_PACKET_LOSS_ALL');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (66, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=dup_packet', 1, 1, 'PERCENTAGE', 'RTP_PACKET_DUP_ALL');
INSERT INTO IRISCONTENT (id, primary_dim, primary_url, snap, trend, view_type, selectedKpiChoice_name)
VALUES (67, 'APPLICATION', '/ita/topn/jittersummary?dimType=APPLICATION&dataType=oos_packet', 1, 1, 'PERCENTAGE', 'RTP_PACKET_OOS_ALL');

-- 7. table DASHLET, add 4 records
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (64, 300, 1, 'app-detail-jitter', 0, 'Average Jitter', 940, 0, 1240, 64);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (65, 300, 1, 'app-detail-loss-packet', 0, 'Packet Loss', 465, 0, 1550, 65);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (66, 300, 1, 'app-detail-duplicate-packet', 0, 'Duplicate Packet', 465, 475, 1550, 66);
INSERT INTO DASHLET (id, height, maximizable, naturalId, realTimeAllowed, title, width, x, y, content_id)
VALUES (67, 300, 1, 'app-detail-out-of-sequence-packet', 0, 'Out of Sequence Packet', 465, 0, 1860, 67);

-- 8. table DASHBOARD_DASHLET, add 4 records 
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 64);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 65);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 66);
INSERT INTO DASHBOARD_DASHLET (dashboard_id, dashlets_id) VALUES (7, 67);

-- 9. table IRISCONTENT_KPICHOICE, add 12 records
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_JITTER_ALL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_JITTER_AUDIO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (64, 'RTP_JITTER_VIDEO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_PACKET_LOSS_ALL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_PACKET_LOSS_AUDIO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (65, 'RTP_PACKET_LOSS_VIDEO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_PACKET_DUP_ALL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_PACKET_DUP_AUDIO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (66, 'RTP_PACKET_DUP_VIDEO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_PACKET_OOS_ALL');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_PACKET_OOS_AUDIO');
INSERT INTO IRISCONTENT_KPICHOICE (iriscontent_id, kpiChoices_name) VALUES (67, 'RTP_PACKET_OOS_VIDEO');

-- 10. table IRISDRILL, add x records
-- Reserved 
-- INSERT INTO IRISDRILL (id, from_dim)
-- VALUES()

-- 11. table IRISDRILL_DASHBOARD, add x records
-- Reserved 
-- INSERT INTO IRISDRILL_DASHBOARD (irisdrill_id, toDetailPages_id)
-- VALUES()

-- 12. table KPICHOICE_TO_METAKPI, add 12 records
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_JITTER_ALL', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_JITTER_AUDIO', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_JITTER_VIDEO', 465, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_LOSS_ALL', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_LOSS_AUDIO', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_LOSS_VIDEO', 465, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_DUP_ALL', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_DUP_AUDIO', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_DUP_VIDEO', 465, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_OOS_ALL', 463, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_OOS_AUDIO', 464, 1);
INSERT INTO KPICHOICE_TO_METAKPI (choice_id, kpi_id, kpi_position) VALUES ('RTP_PACKET_OOS_VIDEO', 465, 1);

-- 13. table KPIGROUP_TO_METAKPI, add 12 records 
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_JITTER_TIME_NUM', 465, 3);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_LOSS_PERCENTAGE', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_LOSS_PERCENTAGE', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_LOSS_PERCENTAGE', 465, 3);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_DUP_PERCENTAGE', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_DUP_PERCENTAGE', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_DUP_PERCENTAGE', 465, 3);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_OOS_PERCENTAGE', 463, 1);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_OOS_PERCENTAGE', 464, 2);
INSERT INTO KPIGROUP_TO_METAKPI (GROUP_ID,KPI_ID,kpi_position) VALUES ('RTP_PACKET_OOS_PERCENTAGE', 465, 3);

-- 14. table META_KPI_QUERY, add 4 records
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (62, 'RTP_JITTER_TIME_NUM', 'rtpCodecType,bin1,bin2,bin3,bin4,bin5,binTotal,timeStamp', 'LONG,LONG,LONG,LONG,LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(rtp_jitter_bin1) as bin1,sum(rtp_jitter_bin2) as bin2,sum(rtp_jitter_bin3) as bin3,sum(rtp_jitter_bin4) as bin4,sum(rtp_jitter_bin5) as bin5,sum(rtp_jitter_total) as binTotal,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpJitterSummary', '');
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (63, 'RTP_PACKET_LOSS_PERCENTAGE', 'rtpCodecType,targetPacket,num_packets,timeStamp', 'LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(rtp_packet_loss) as targetPacket,sum(rtp_total_packet) as num_packets,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpPacketSummary', '');
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (64, 'RTP_PACKET_DUP_PERCENTAGE', 'rtpCodecType,targetPacket,num_packets,timeStamp', 'LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(rtp_dup_packet) as targetPacket,sum(rtp_total_packet) as num_packets,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpPacketSummary', '');
INSERT INTO META_KPI_QUERY (id,name,fieldsList,typeList,selectString,caseStmtFunction,sourceTable,groupByList,classificationType,resultBeanName,whereList)
VALUES (65, 'RTP_PACKET_OOS_PERCENTAGE', 'rtpCodecType,targetPacket,num_packets,timeStamp', 'LONG,LONG,LONG,TIMESTAMP', 'rtp_codec_type as rtpCodecType,sum(rtp_out_of_sequence) as targetPacket,sum(rtp_total_packet) as num_packets,time_stamp as timeStamp', '', 'com.tek.iris.persist.active.LinkApplnRtpStats', 'time_stamp,rtpCodecType', 5, 'com.tek.iris.beans.summary.RtpPacketSummary', '');
