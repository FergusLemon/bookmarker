# Bookmarker
A simpe web application that allows users to bookmark websites, view and visit those websites from a list of all bookmarks, add comments and tags to an individual bookmark and delete bookmarks.  This application was built as part of the Makers Academy course (week 4). The website is not being hosted on an external service so to use it a user has to run it locally on their own device, instructions for doing so are available below.  

### Build status
[![Build Status](https://travis-ci.org/FergusLemon/bookmarker.svg?branch=master)](https://travis-ci.org/FergusLemon/bookmarker)

Travis CI has been used for continuous integration testing on this project.

### Database Instructions
This project maintains two databases, one test database and one production database.  Rake tasks have been defined for database clean up before running tests as well as database setup for both production and test databases. Running the command `rake setup` from the command line will setup the databases initially, the test rake task will be run automatially before each set of tests.  In the directory `bookmarker/db/migrations` can be found the various individual steps for creating the proper database and table setup.

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

### Technologies Used
Written in Ruby, SQL, HTML and CSS.

Postgres Database.

Sinatra as the web framework.

Tests run using RSpec and Capybara.

### Dependencies
All dependencies can be found in the `Gemfile` and `Gemfile.lock`.  Bundler was used to manage dependencies.

### License
MIT (c) 2018 Fergus Lemon

See `LICENSE` for more detail.
