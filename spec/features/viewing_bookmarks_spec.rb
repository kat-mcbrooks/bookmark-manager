feature 'Viewing bookmarks' do
  scenario 'visiting index' do
    visit '/'
    expect(page).to have_content "Bookmark Manager"
  end

  scenario 'bookmarks are displayed' do
    visit '/bookmarks'
    expect(page).to have_content "https://stackoverflow.com"
    expect(page).to have_content "https://www.twilio.com"
    expect(page).to have_content "https://bundler.io"
  end
end