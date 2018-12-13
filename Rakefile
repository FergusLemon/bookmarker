require 'rspec/core/rake_task'
require 'pg'

task default: :spec

desc 'Run the specs.'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

task :test_database_setup do
  p "Cleaning database..."

   conn = PG.connect(dbname: 'bookmarker_test')
   conn.exec("TRUNCATE bookmarks RESTART IDENTITY CASCADE;")
   conn.exec("TRUNCATE comments RESTART IDENTITY CASCADE;")
   conn.exec("TRUNCATE tags RESTART IDENTITY CASCADE;")
   conn.exec("TRUNCATE bookmark_tags RESTART IDENTITY CASCADE;")
   conn.exec("TRUNCATE users RESTART IDENTITY CASCADE;")
end

task :setup do
  p "Creating databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")
    connection.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks(id));")
    connection.exec("CREATE TABLE tags(id SERIAL PRIMARY KEY, content VARCHAR(60));")
    connection.exec("CREATE TABLE bookmark_tags(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks(id), tag_id INTEGER REFERENCES tags(id));")
    connection.exec("CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(24), password VARCHAR(124));")
  end
end
