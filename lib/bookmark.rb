require 'pg'

class Bookmark

  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all 
    if ENV['ENVIRONMENT'] == 'test' # if we are running tests, bookmarks will be read from bookmark_manager_test db
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager') # if we are running the app(i.e. when we're in the development environment), bookmarks will be read from the REAL bookmark_manager db. nb we haven't set the ENV['ENVIRONMENT'] var so it is nil
    end

    result = connection.exec('SELECT * FROM bookmarks;') # calling exec on the connection object, passing in a query string, to retrieve everything in the table
  
    enumerator = result.map do |bookmark| 
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title']) #wrapping each db entry in a Bookmark instance, with instance variables id, url, title
    end
    
    
  end

  def self.create(url:, title:) #class method because we don't want to create a new instance of Bookmark everytime we add a bookmark. We want all bookmarks added within the db bookmark_manager to belong to one instance of Bookmark. keyword arg so that url can be passed in the controller 
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') 
    else
      connection = PG.connect(dbname: 'bookmark_manager') # calling connect on the PG object, passing in db name, returns an object we can send a query to(line below)
    end
    result = connection.exec_params("INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, url, title;", [url, title]) #we need the SQL query to return the Bookmark we're creating, so we can check that the Bookmark has been created with the given values. This also removes any dependency on the .all method.
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title']) #you can't just call result['id' because result is an enumerator object with one hash inside it. It needs to be given [0] to instruct it to look within that hash]
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') 
    else
      connection = PG.connect(dbname: 'bookmark_manager') 
    end
    result = connection.exec_params("DELETE FROM bookmarks WHERE id=$1;", [id]) 
  end

  def self.update(id:, url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') 
    else
      connection = PG.connect(dbname: 'bookmark_manager') 
    end
  
    result = connection.exec_params(
      "UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;",
      [url, title, id]
  )
  Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id: ) 
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test') 
    else
      connection = PG.connect(dbname: 'bookmark_manager') 
    end
    result = connection.exec_params("SELECT * FROM bookmarks WHERE id = $1;", [id])
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url']) #even though we are 'finding' the bookmark in the db, we need to create a new instance of Bookmark in ruby (wrapping in a useful Ruby object). We need to return this data as a useful object so that on the webpage, the user can see it.

  end

end