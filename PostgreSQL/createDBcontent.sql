\echo Creating database objects...

--fincfg schema

\echo fincfg:Tables

\i fincfg/Tables/biccodes.sql
\i fincfg/Tables/currencies.sql
\i fincfg/Tables/feedbackcodes.sql
\i fincfg/Tables/idgenlist.sql
\i fincfg/Tables/msgtypes.sql
\i fincfg/Tables/queueactions.sql
\i fincfg/Tables/queuetypes.sql
\i fincfg/Tables/qtypeactionmaps.sql
\i fincfg/Tables/servicemaps.sql
\i fincfg/Tables/queues.sql
\i fincfg/Tables/qmoveprivmaps.sql
\i fincfg/Tables/queuemsggroups.sql
\i fincfg/Tables/routingkeywords.sql
\i fincfg/Tables/routingkeywordmaps.sql
\i fincfg/Tables/timelimits.sql
\i fincfg/Tables/routingschemas.sql
\i fincfg/Tables/routingrules.sql
\i fincfg/Tables/usersecurity.sql
\i fincfg/Tables/userlogs.sql
\i fincfg/Tables/roles.sql
\i fincfg/Tables/queuesrolemap.sql
\i fincfg/Tables/users.sql
\i fincfg/Tables/usersrolemap.sql
\i fincfg/Tables/passhistory.sql
\i fincfg/Tables/versions.sql
\i fincfg/Tables/nbdcalendar.sql
\i fincfg/Tables/reportingtxstates.sql
\i fincfg/Tables/params.sql



\echo fincfg:Functions

\i fincfg/Functions/changequeuestatus.sql
\i fincfg/Functions/getactiveschemas.sql
\i fincfg/Functions/getkeywordmappings.sql
\i fincfg/Functions/getkeywords.sql
\i fincfg/Functions/getmsgtypebusinessname.sql
\i fincfg/Functions/getqueues.sql
\i fincfg/Functions/getrule.sql
\i fincfg/Functions/getrulesforschema.sql
\i fincfg/Functions/getservicestate.sql
\i fincfg/Functions/gettimelimits.sql
\i fincfg/Functions/updateservicestate.sql
\i fincfg/Functions/updateversion.sql
\i fincfg/Functions/getduplicatesettings.sql
\i fincfg/Functions/getlastbusinessday.sql
\i fincfg/Functions/getusername.sql


\echo fincfg:Data


\i fincfg/Data/data.sql




--findata schema


\echo findata:Tables

\i findata/Tables/batchjobs.sql
\i findata/Tables/batchjobsinc.sql
\i findata/Tables/batchrequests.sql
\i findata/Tables/entryqueue.sql
\i findata/Tables/history.sql
\i findata/Tables/routingjobs.sql
\i findata/Tables/serviceperformance.sql
\i findata/Tables/status.sql
\i findata/Tables/tempbatchjobs.sql
\i findata/Tables/routedmessages.sql
\i findata/Tables/feedbackagg.sql
\i findata/Tables/messagehashes.sql
\i findata/Tables/blobsqueue.sql


\echo findata:Sequences

\i findata/Sequences/commbatchseq.sql
\i findata/Sequences/batchrequests_requestid_seq.sql


\echo findata:Functions

\i findata/Functions/getnextservicesequence.sql
\i findata/Functions/abortjob.sql
\i findata/Functions/batchjob.sql
\i findata/Functions/commitjob.sql
\i findata/Functions/createbatchrequest.sql
\i findata/Functions/deferbatchjob.sql
\i findata/Functions/deferjob.sql
\i findata/Functions/deletemessagefromqueue.sql
\i findata/Functions/getbatchjobs.sql
\i findata/Functions/getbatchstatus.sql
\i findata/Functions/getbatchtype.sql
\i findata/Functions/getbusinessdateformat.sql
\i findata/Functions/getfirstjob.sql
\i findata/Functions/getfirstnewjob.sql
\i findata/Functions/getgroupsformtqueue.sql
\i findata/Functions/getgroupsheaderformtqueue.sql
\i findata/Functions/getmessagesinbatch.sql
\i findata/Functions/getoriginalmessageid.sql
\i findata/Functions/getoriginalpayload.sql
\i findata/Functions/getoriginalref.sql
\i findata/Functions/insertevent.sql
\i findata/Functions/insertincomingbatch.sql
\i findata/Functions/insertmessage.sql
\i findata/Functions/insertmessageinqueue.sql
\i findata/Functions/loadqpcms.sql
\i findata/Functions/modifymessageinqueue.sql
\i findata/Functions/movemessageinqueue.sql
\i findata/Functions/readmessageinqueue.sql
\i findata/Functions/resumejobs.sql
\i findata/Functions/rollbackjob.sql
\i findata/Functions/terminatebatch.sql
\i findata/Functions/trg_insertroutingjob.sql
\i findata/Functions/updatemessageinqueue.sql
\i findata/Functions/updaterefusalfbcode.sql
\i findata/Functions/updatermack.sql
\i findata/Functions/updatermackbatch.sql
\i findata/Functions/updatermassembleresponder.sql
\i findata/Functions/updatermresponder.sql
\i findata/Functions/updatermuserid.sql
\i findata/Functions/updatermvaluedate.sql

\i findata/Functions/gethash.sql
\i findata/Functions/inserthash.sql
\i findata/Functions/purgehashes.sql

\i findata/Functions/direfusaldelall.sql
\i findata/Functions/direfusalgetall.sql
\i findata/Functions/getimageforcsm.sql
\i findata/Functions/insertimgblobsqueue.sql
\i findata/Functions/readimage.sql
\i findata/Functions/updatecorridblobsqueue.sql



\echo findata:Triggers

\i findata/Triggers/trgaientryqueue.sql



