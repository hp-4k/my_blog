require 'rails_helper'

RSpec.feature 'comments', type: :feature do
  
  scenario 'add and delete a comment' do
    
    @user = create(:user) do |user|
      user.articles.create(attributes_for(:article, title: 'foobar'))
    end
    
    visit article_path('foobar')
    
    # check that empty comments are not accepted
    click_button 'Comment'
    expect(page).to have_content('required')
    
    # check a new comment is created
    fill_in 'Name', with: 'qux'
    fill_in 'Comment', with: 'barbaz body'
    click_button 'Comment'
    
    within('.comment') do
      expect(page).to have_content('qux')
      expect(page).to have_content('barbaz body')
    end
    
    # check that not logged in users can't delete comments
    expect(page).not_to have_selector(:link_or_button, 'Delete this comment')
    
    # check that logged in users can delete comments
    log_in_with_ui_as(@user)
    visit article_path('foobar')
  
    click_link 'Delete this comment'
    
    expect(page).to have_content('deleted')
    expect(page).not_to have_selector('.comment')
      
  end
  
end