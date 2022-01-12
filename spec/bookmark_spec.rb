require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmark.create(url: "http://www.google.com", title: 'Google')
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: 'Dangerous website!')

      bookmarks = Bookmark.all
      
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do 
    it 'creates a new bookmark' do 
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test Bookmark') #pushing the data to the db
      
      persisted_data = persisted_data(id: bookmark.id) #runs the method defined in db_helpers that selects bookmarks with ids matching bookmark.id from bookmark_manager_test db. pulls the data back from the db
    
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id'] #must retrieve this from the db 
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.example.org'
    end
  end

  describe '.delete' do 
    it 'deletes a bookmark' do 
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test Bookmark')
    
      Bookmark.delete(id: bookmark.id)
      
      expect(Bookmark.all).not_to include bookmark
    end
  end

end
