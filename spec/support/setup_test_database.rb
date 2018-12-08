require 'pg'
module DatabaseHelpers
  def truncate_table
   conn = PG.connect(dbname: 'bookmarker_test')
   conn.exec("TRUNCATE bookmarks RESTART IDENTITY CASCADE;")
   conn.exec("TRUNCATE comments RESTART IDENTITY CASCADE;")
  end
end
