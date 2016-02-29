require 'rails_helper'

RSpec.feature 'users', type: :feature do
  
  scenario 'user signs up' do
    
    visit '/signup'
    
    fill_in 'Name', with: 'foobar'
    fill_in 'Email', with: "foo@bar.baz"
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'does not match'
    click_button "Sign up"
    
    expect(page).to have_content("errors")
    
    fill_in 'Name', with: 'foobar'
    fill_in 'Email', with: "foo@bar.baz"
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_button "Sign up"
    
    expect(page).to have_current_path(articles_for_user_path('foobar'))
    
  end
  
  scenario 'users signs in and signs out' do
    
    user = create(:user, email: 'foo@bar.baz', name: 'foobar')
    
    visit root_url
    
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong'
    click_button 'Sign in'
    
    expect(page).to have_content 'Invalid'
    
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    
    expect(page).to have_current_path(articles_for_user_path('foobar'))
    
    click_link 'Sign out'
    
    expect(page).to have_content('logged out')
    expect(page).to have_current_path(root_path)
    
  end
  
end