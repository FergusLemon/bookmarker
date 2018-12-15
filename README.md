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
- [ ] Run the query saved in the file `\db\migrations\01_create_bookmarks_table.sql`;
- [ ] Run the query saved in the file `\db\migrations\02_add_title_column_to_bookmarks.sql`.

##### Test
- [ ] Connect to PostgresQL via the command line using the `psql` command;
- [ ] Create the database using the psql command `CREATE DATABASE bookmarker_test`;
- [ ] Connect to the database using the pqsl command `\c bookmarker_test`;
- [ ] Run the query saved in the file `\db\migrations\01_create_bookmarks_table.sql`;
- [ ] Run the query saved in the file `\db\migrations\02_add_title_column_to_bookmarks.sql`.

### Installation

- [ ] **Step 1** - Clone this repository by copying the link available at the top of this webpage in the green button labelled 'Clone or Download'. 
- [ ] **Step 2** - Open up a Terminal window (Mac OS) and run `git clone <link>` where `<link>` is what you copied in the previous step.
```
>> git clone https://github.com/FergusLemon/bookmarker.git
```
- [ ] **Step 3** - `cd` into the cloned directory.
- [ ] **Step 4** - Run the `rackup` command.  This will start a server on port `9292` by default.  If you want to set a different port number just run the command with the `-p` flag; for example: `rackup -p 9494` if you wanted to start the server on port 9494.
- [ ] **Step 5** - Open a browser and visit `localhost:9292` (if you have changed the default port then use that number instead).  You should now see the landing page for Bookmarker, where you can sign in with your email and a password.

### Tests
Unit tests can be located in the `spec` directory and can be run from the `bookmarker` directory using the command `rake`.  Feature tests can be found in the `spec/features` directory, in these feature test files you'll also find user stories (commented out) that relate to the feature tests.

The Rubocop style guide has been used to inform the style of the code, most recommendations have been updated for and the remaining recommendations can be seen by using the `rubocop` command from the `bookmarker` directory.  
The decision was made to ignore some recommendations relating to line length due to readability and comments due to the simple nature of the objects that make up the codebase.

### Dependencies
All dependencies can be found in the `Gemfile` and `Gemfile.lock`.  Bundler was used to manage dependencies.

### License
MIT (c) 2018 Fergus Lemon

See `LICENSE` for more detail.
