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



INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('MSGTYPES_MTID', 400);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QMOVEPRIVMAPS_MAPID', 1001);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QTYPEACTIONMAPS_MAPID', 1);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ERRORCODES_GUID', 2);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROLES_ROLEID', 151);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUES_GUID', 199);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGSCHEMAS_GUID', 22402);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('TIMELIMITS_GUID', 36453);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUETYPES_TYPEID', 19680);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUEACTIONS_ACTIONID', 13366);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEPERFORMANCE_SERVICEID', 16151);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERSROLEMAP_MAPID', 2460);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUESROLEMAP_MAPID', 2451);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDMAPS_MAPID', 19260);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGRULES_GUID', 54460);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEMAPS_SERVICEID', 18401);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDS_GUID', 20301);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ALERTS_ALERTID', 9800);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERS_USERID', 201);
COMMIT;


INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (0, 'Authorize', '', 1, 1, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (6, 'Create Refusal Message', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (12, 'Security:Pass', '', 0, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (13, 'Security:Fail', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (14, 'Move to Edit', '', 0, 0, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (3, 'Reject', '', 1, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (4, 'Reject after COT', '', 0, 0, 1, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (7, 'Client Reject', '', 0, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (16, 'View Possible Duplicates', 'pe coada de tip duplicate/investig?', 1, 0, 0, NULL, 0);
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
  (101, 'Reference', 'string', '(?<value>.*)', 'Transaction reference', '(?<value>.*)'),                         
  (104, 'Currency', 'string', '(?<value>[A-Z]{3})', 'Amount currency', '(?<value>[A-Z]{3})'),
  (107, 'OrdBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Ordering bank', '(?<value>[A-Z 0-9]{8})'),                              
  (108, 'BenBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Beneficiary bank', '(?<value>[A-Z 0-9]{8})'),      
  (111, 'Service', 'string', '(?<value>.*)', 'Payment service', '(?<value>.*)'),                  
  (113, 'Receiver', 'string', '(?<value>[A-Z 0-9]{8})', 'Receiver bank BIC', '(?<value>.*)'),     
  (124, 'OrigRef', 'string', '(?<value>.*)', 'Original transaction reference', '(?<value>.*)'),   
  (125, 'OrigBatchID', 'string', '(?<value>.*)', 'Original batch identifier', '(?<value>.*)'),  
  (126, 'RelRef', 'string', '(?<value>.*)', 'Related transaction reference', '(?<value>.*)'),  
  (103, 'Amount', 'string', E'(?<value>[\\d,\\.]{1,})$', 'Transaction amount', E'(?<value>[\\d,\\.]{1,})$'), 
  (102, 'ValueDate', 'date', E'(?<value>\\d{6,8})', 'Value Date', E'(?<value>\\d{6,8}|\\d{4}[-]\\d{2}[-]\\d{2})'),
  (105, 'DbtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Debtor account number', '(?<value>.*)'),
  (106, 'CdtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Creditor account number', '(?<value>.*)'),
  (109, 'DbtCustName', 'string', E'\\n(?<value>.*)\\n', 'Debtor customer name', '(?<value>.*)'),
  (110, 'CdtCustName', 'string', E'\\n(?<value>.*)\\n', 'Creditor customer name', '(?<value>.*)'),
  (112, 'Sender', 'string', '(?<value>[A-Z 0-9]{8})', 'Sender bank BIC', '(?<value>[A-Z 0-9]{8})');
COMMIT;



INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (2, 'Administrator', 'n/a', 0);
INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (3, 'Reports', 'n/a', 0);

COMMIT;



