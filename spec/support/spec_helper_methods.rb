module SpecHelperMethods
  
  def log_in_with_ui_as(user)
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
  
end