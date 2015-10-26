require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before do
    visit new_user_url
  end
  scenario "has a new user page" do

    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      fill_in('Username', :with => 'Sennacy')
      fill_in('Password', :with => 'Seekrit')
      click_button('Sign Up')

      expect(page).to have_content("Sennacy")
    end
  end

end

feature "logging in" do
  before do
    sign_up_as_scott_bot
    visit new_session_url
    fill_in('Username', :with => 'scott_bot')
    fill_in('Password', :with => 'abcdef')
  end
  it "shows username on the homepage after login" do
    click_button('Sign In')
    expect(page).to have_content("scott_bot")
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Sign In"
  end
  it "doesn't show username on the homepage after logout" do
    sign_up_as_scott_bot
    visit new_session_url
    fill_in('Username', :with => 'scott_bot')
    fill_in('Password', :with => 'abcdef')
    click_button('Sign In')
    click_button('Sign Out')
    expect(page).to_not have_content("scott_bot")
  end

end

feature "the goals" do

  scenario "page has Goals" do
      sign_in_as_scott_bot
    expect(page).to have_content("Goals")
  end
  scenario "page has new goal link" do
      sign_in_as_scott_bot
    click_link("New Goal")
    expect(page).to have_content("Create Goal")
  end
    scenario "creates a new goal" do
    create_goal_as_scott_bot
    expect(page).to have_content("eat apples")
    #expect(page).to have_content("Ongoing")
  end

  scenario "edits a goal" do
    create_goal_as_scott_bot
    click_link("eat apples")
    click_link("Edit")
    fill_in('Body', :with => 'eat chocolate')
    click_button("Update")
    expect(page).to have_content("eat chocolate")
  end

  scenario "scott_bot cannot access private links of other user" do
    create_p_goal_as_jake_bot
    click_button("Sign Out")
    sign_in_as_scott_bot
    visit user_url(1)
    expect(page).to_not have_content("eat honey")
  end

end
