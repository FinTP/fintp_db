/*
* FinTP - Financial Transactions Processing Application
* Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>
* or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
* phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.
*/

INSERT INTO fincfg.timelimits (guid, limitname, limittime) VALUES (1, 'Start app', '12/9/2013 00:00:01');
INSERT INTO fincfg.timelimits (guid, limitname, limittime) VALUES (2, 'Stop app', '12/9/2013 23:59:59');
COMMIT;

INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('MSGTYPES_MTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QMOVEPRIVMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QTYPEACTIONMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ERRORCODES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROLES_ROLEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('BATCHREQUESTS_REQUESTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUETYPES_TYPEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEPERFORMANCE_SERVICEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERSROLEMAP_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGRULES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUEACTIONS_ACTIONID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEMAPS_SERVICEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGSCHEMAS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('TIMELIMITS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUESROLEMAP_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ALERTS_ALERTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERS_USERID', 999);
COMMIT;


INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (103, 'Complete', 0, NULL, 103, 0, 'Complete queue', 10, '');
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (3, 'History', 0, NULL, 105, 0, 'History queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (13, 'InvestigOutQueue', 0, NULL, 103, 0, 'Investigation queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (12, 'InvestigInQueue', 0, NULL, 103, 0, 'Investigation queue', 50, NULL);




INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (0, 'Authorize', '', 1, 1, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (6, 'Create Refusal Message', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (12, 'Security:Pass', '', 0, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (13, 'Security:Fail', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (14, 'Move to Edit', '', 0, 0, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (3, 'Reject', '', 1, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (4, 'Reject after COT', '', 0, 0, 1, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (7, 'Client Reject', '', 0, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (16, 'View Possible Duplicates', '', 1, 0, 0, NULL, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (1, 'Batch', '', 0, 1, 1, 60, 1);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (2, 'Move', '', 1, 1, 0, 50, 1);
COMMIT;


INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (101, 'Payment');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (102, 'Duplicate');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (103, 'Investigation');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (104, 'Sanction');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (105, 'History');
COMMIT;


INSERT INTO fincfg.routingkeywords (guid, keyword, comparer, selector, description, selectoriso) VALUES
  (134, 'OrigInstrID', 'string', '(?<value>.*)', 'Original Instructed ID', '(?<value>.*)'),
  (117, 'TTC', 'string', '(?<value>.*)', 'Transaction type code', '(?<value>.*)'),  
  (124, 'OrigRef', 'string', '(?<value>.*)', 'Original transaction reference', '(?<value>.*)'),
  (125, 'OrigBatchID', 'string', '(?<value>.*)', 'Original batch identifier', '(?<value>.*)'),
  (126, 'RelRef', 'string', '(?<value>.*)', 'Related transaction reference', '(?<value>.*)'),
  (127, 'RCode', 'string', '(?<value>.*)', 'Reason code', '(?<value>.*)'),
  (129, 'DbtID', 'string', E'(?:[^\\n]*\\n)*(?<value>.*)$', 'Debtor ID', '(?<value>.*)'),
  (102, 'ValueDate', 'string', E'(?<value>\\d{6,8})', 'Value Date', E'(?<value>\\d{6,8}|\\d{4}[-]\\d{2}[-]\\d{2})'),
  (101, 'Reference', 'string', '(?<value>.*)', 'Reference', '(?<value>.*)'),
  (103, 'Amount', 'string', E'(?<value>[\\d,\\.]{1,})$', 'Amount', E'(?<value>[\\d,\\.]{1,})$'),
  (104, 'Currency', 'string', '(?<value>[A-Z]{3})', 'Currency', '(?<value>[A-Z]{3})'),
  (105, 'DbtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Debtor Account', '(?<value>.*)'),
  (106, 'CdtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Creditor Account', '(?<value>.*)'),
  (132, 'IssDate', 'date', '(?<value>d{6,8})', 'Issuance Date', '(?<value>.*)'),
  (107, 'OrdBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Ordering Bank', '(?<value>[A-Z 0-9]{8})'),
  (108, 'BenBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Beneficiary Bank', '(?<value>[A-Z 0-9]{8})'),
  (128, 'MatDate', 'date', '(?<value>.*)', 'Maturity Date', '(?<value>.*)'),
  (109, 'DbtCustName', 'string', E'[^\\n]*\\n(?<value>[^\\n]*)\\n.*', 'Debtor Customer Name', '(?<value>.*)'),
  (110, 'CdtCustName', 'string', E'[^\n]*\n(?<value>[^\n]*)[\n]*.*', 'Creditor Customer Name', '(?<value>.*)'),
  (111, 'Service', 'string', '(?<value>.*)', 'Service', '(?<value>.*)'),
  (112, 'Sender', 'string', '(?<value>[A-Z 0-9]{8})', 'Sender', '(?<value>[A-Z 0-9]{8})'),
  (113, 'Receiver', 'string', '(?<value>[A-Z 0-9]{8})', 'Receiver', '(?<value>.*)'),
  (133, 'CdtID', 'string', E'(?:[^\\n]*\\n)*(?<value>.*)$', 'Creditor ID', '(?<value>.*)');
COMMIT;



INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (2, 'Administrator', 'n/a', 0);
INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (3, 'Reports', 'n/a', 0);

Insert into FINCFG.USERS (USERID, USERNAME, PASSWORD, SKINCOLOR, ISLOCKED, NORETRY, PAYMSETPREF, QSETPREF)
 Values  (52, 'admin', '670657fe99ad06927fbe160317f55d57cf8060a7e2f327b9c2b15859e4bac62135ad0045fd0ab1c4','Blue', 0, 4, 'all', 'all');
COMMIT;
INSERT INTO fincfg.users (userid, username, "password", firstname, lastname, skincolor, islocked, noretry, email, passdate, paymsetpref, qsetpref) VALUES (999, 'user1', 'cVBheWFkbWluYzQzNnY=', 'user', NULL, 'Blue', 0, 0, NULL, '1/17/2014', 'all', 'all');
INSERT INTO fincfg.users (userid, username, "password", firstname, lastname, skincolor, islocked, noretry, email, passdate, paymsetpref, qsetpref) VALUES (998, 'user2', 'cVBheWFkbWluYzQzNnY=', 'user', '', 'Blue', 0, 0, NULL, '1/17/2014', 'all', 'all');
INSERT INTO fincfg.users (userid, username, "password", firstname, lastname, skincolor, islocked, noretry, email, passdate, paymsetpref, qsetpref) VALUES (997, 'user3', 'cVBheWFkbWluYzQzNnY=', 'user', '', 'Blue', 0, 0, NULL, '1/17/2014', 'all', 'all');
COMMIT;

INSERT INTO fincfg.usersrolemap (mapid, userid, roleid) VALUES (2121, 999, 2);
INSERT INTO fincfg.usersrolemap (mapid, userid, roleid) VALUES (2122, 998, 2);
INSERT INTO fincfg.usersrolemap (mapid, userid, roleid) VALUES (2123, 997, 2);
Insert into FINCFG.USERSROLEMAP   (MAPID, USERID, ROLEID) Values  (1, 52, 2);
COMMIT;

INSERT INTO fincfg.params (name, value, description, category) VALUES ('Duplicate Detection Period', '999', '*business days', 'ARCHIVE');
COMMIT;

INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Blocking funds)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Refusal to Pay)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Reinitiate)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Interface sucess', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Interface error', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Network accepted', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Network error', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('New', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Partially refused', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Partially settled', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Possible Duplicate', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Reactivated', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Received', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Refused', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected by user', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected by client', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected after COT', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Sent', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Settled', NULL);
COMMIT;


INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (102, 3, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (104, 13, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (105, 12, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (109, 103, 2, 'RW');


INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('EventsWatcher', 1, 3, 0, 0, now(), NULL, NULL, 0, NULL, NULL, '538c2a62-19c55082-7e820001', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('RoutingEngine', 3, 3, 0, 0, now(), NULL, NULL, 0, NULL, NULL, '538c2a62-83ec5082-b63b0001', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('FinTPDB000', 10, 3, 0, 50, now(), NULL, 'DB Service', 1, NULL, NULL, '538c2a63-308a5082-23320001', NULL, NULL, NULL, NULL, NULL);

INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (10, now(), 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (1, now(), 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (3, now(), 0, 0, 0, 0, 0, 0, 0, 0);
