def setup_test_database # helper method which is configured to run (via the spec_helper) before each RSpec spec, so that every test starts with a 'clean' test database
  require 'pg' # an interface to the PostgreSQL server

  p 'Setting up test database...'
  connection = PG.connect(dbname: 'bookmark_manager_test')

  # clear the bookmarks table (within bookmark_manager_test db)
  connection.exec("TRUNCATE bookmarks;")
end 