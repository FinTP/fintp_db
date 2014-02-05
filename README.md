fintp_db
========

FinTP database



Requirements
---------------------

- PostgreSQL 9.1 server


Installation
---------------------

**Initialize database**

You need PostgreSQL 9.1 installed.
Run 'bin/init' to initialize database structure

**Configure database**

- create database
- create schemas and specific users (fincfg, findata)
- create user for fintp_api (finuiuser)
- create one tablespace for each user (fincfgtbs, findatatbs)
- grant user privileges 

        psql -f grantPrivs.sql -U postgres -d <database_name>
- run createDBcontent.sql script file (if subsequent runs, you must drop and recreate the schemas first)

        psql -f createDBcontent.sql -U postgres -d <database_name>
- [optional] run specific *Message flow* scripts in /PostgreSQL/messageflows


Contributing
-----
See [How To Contribute](http://www.fintp.org/how-to-contribute) for a list of areas where help is welcome.

License
-----
- [GPLv3](http://www.gnu.org/licenses/gpl-3.0.html)

Copyright
-----
FinTP - Financial Transactions Processing Application
Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
