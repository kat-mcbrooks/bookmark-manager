require 'pg'

class Bookmark
  def self.all 
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') # calling connect on the PG object, passing in db name, returns an object we can send a query to(line below)
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks;') # calling exec on the connection object, passing in a query string
    result.map {|bookmark| bookmark['url']}
  end

  def self.create(url:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') # calling connect on the PG object, passing in db name, returns an object we can send a query to(line below)
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  
    connection.exec("INSERT INTO bookmarks (url) VALUES ('#{url}');")
  end
end