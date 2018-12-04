# Bookmarker

### Build status
[![Build Status](https://travis-ci.org/FergusLemon/bookmarker.svg?branch=master)](https://travis-ci.org/FergusLemon/bookmarker)

Travis CI has been used for continuous integration testing on this project.

### Database Instructions
This project maintains two databases, one test database and one production database.  Below are the instructions for recreating them.

##### Production
- [ ] Connect to PostgresQL via the command line using the `psql` command;
- [ ] Create the database using the psql command `CREATE DATABASE bookmarker`;
- [ ] Connect to the database using the pqsl command `\c bookmarker`;
- [ ] Run the query saved in the file `\db\migrations\01_create_bookmarks_table.sql`.

##### Test
- [ ] Connect to PostgresQL via the command line using the `psql` command;
- [ ] Create the database using the psql command `CREATE DATABASE bookmarker_test`;
- [ ] Connect to the database using the pqsl command `\c bookmarker_test`;
- [ ] Run the query saved in the file `\db\migrations\01_create_bookmarks_table.sql`.
