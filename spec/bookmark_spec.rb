require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.all
       
      expect(bookmarks).to include("https://stackoverflow.com")
      expect(bookmarks).to include("https://www.twilio.com")
      expect(bookmarks).to include("https://bundler.io")
    end
  end
end
