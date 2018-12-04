require 'pg'
module DatabaseHelpers
  def truncate_table
   conn = PG.connect(dbname: 'bookmarker_test')
   conn.exec("TRUNCATE bookmarks")
  end
end
