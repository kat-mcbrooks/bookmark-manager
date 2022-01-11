feature 'Viewing bookmarks' do
  scenario 'visiting the homepage shows page title' do
    visit '/'
    expect(page).to have_content "Bookmark Manager"
  end

  scenario 'user can view list of bookmarks at /bookmarks' do 
    Bookmark.create(url: "http://www.makersacademy.com") #refactored this (previously we connected to the test db and inserted dummy test data urls. But now that the Model Bookmark class has a way of inserting data to the real db, we can do it this way instead)
    Bookmark.create(url: "http://www.google.com")
    Bookmark.create(url: "http://www.destroyallsoftware.com")

    visit '/bookmarks'

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
  end
end