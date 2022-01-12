feature 'deleting bookmarks' do 
  scenario 'a user can delete a bookmark' do 
    visit('/bookmarks/new')
    fill_in('url', with: 'http://example.org')
    fill_in('title', with: 'Test Bookmark')
    click_button('Add bookmark')
    expect(page).to have_link('Test Bookmark', href: 'http://example.org')


    all('.bookmark').last.click_button('Delete')     # or first('.bookmark').click_button('Delete')  
    expect(current_path).to eq '/bookmarks' #testing that after hitting delete button, we're still on the bookmarks list page
    expect(page).not_to have_link('Test Bookmark', href: 'http://example.org')
  end
end
