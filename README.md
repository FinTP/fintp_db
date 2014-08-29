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

- create database (name it *fintpce* if intended to run the prebuilt scenarios)
- create schemas and specific users (fincfg, findata)
- create user for fintp_api (finuiuser)
- create one tablespace for each user (fincfgtbs, findatatbs)
- grant user privileges 

        psql -f grantPrivs.sql -U postgres -d <database_name>
- run createDBcontent.sql script file (if subsequent runs, you must drop and recreate the schemas first)

        psql -f createDBcontent.sql -U postgres -d <database_name>


Usage
-----
See [Samples](https://github.com/FinTP/fintp_samples) for a list of usage scenarios.

Contributing
-----
See [How To Contribute](http://www.fintp.org/how-to-contribute) for a list of areas where help is welcome.

License
-----
- [GPLv3](http://www.gnu.org/licenses/gpl-3.0.html)

Copyright
-------
COPYRIGHT.  Copyright to the SOFTWARE is owned by ALLEVO and is protected by the copyright laws of all countries and through international treaty provisions. 
NO TRADEMARKS.  Customer agrees to remove all Allevo Trademarks from the SOFTWARE (i) before it propagates or conveys the SOFTWARE or makes it otherwise available to third parties and (ii) as soon as the SOFTWARE has been changed in any respect whatsoever. 
