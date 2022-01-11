require 'pg'

class Bookmark
  def self.all 
    if ENV['ENVIRONMENT'] == 'test' # if we are running tests, bookmarks will be read from bookmark_manager_test db
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager') # if we are running the app(i.e. when we're in the development environment), bookmarks will be read from the REAL bookmark_manager db. nb we haven't set the ENV['ENVIRONMENT'] var so it is nil
    end

    result = connection.exec('SELECT * FROM bookmarks;') # calling exec on the connection object, passing in a query string
    result.map {|bookmark| bookmark['url']}
  end

  def self.create(url:) #class method because we don't want to create a new instance of Bookmark everytime we add a bookmark. We want all bookmarks added within the db bookmark_manager to belong to one instance of Bookmark. keyword arg so that url can be passed in the controller 
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') 
    else
      connection = PG.connect(dbname: 'bookmark_manager') # calling connect on the PG object, passing in db name, returns an object we can send a query to(line below)
    end
    connection.exec("INSERT INTO bookmarks (url) VALUES ('#{url}');") #we need to interpolate the var url because its in a query string here
  end
end