require 'rails_helper'

RSpec.feature 'articles', type: :feature do
  
  before :each do
    @user = create(:user, name: 'foobar')
    log_in_with_ui_as(@user)
  end
  
  scenario 'user creates, edits and deletes an article' do
    
    visit new_article_path
    
    click_button 'Publish'
    expect(page).to have_content('errors')
    
    test_content = <<-END_TEXT
# Test article

1. One
2. Two
3. Three

A paragraph
END_TEXT
      
    fill_in 'Title', with: 'Test article'
    fill_in 'Content', with: test_content
    click_button 'Publish'
    
    expect(page).to have_current_path(article_path('test-article'))
    within('.article-content') do
      expect(page).to have_selector('h1')
      expect(page).to have_selector('ol')
      expect(page).to have_selector('p')
    end
    
    click_link 'Edit it'
    
    fill_in 'Content', with: '## edited article'
    click_button 'Update'
    
    within('.article-content') do
      expect(page).to have_selector('h2')
    end
    
    click_link 'Delete it'
    expect(page).to have_content('deleted')
    
  end
  
end