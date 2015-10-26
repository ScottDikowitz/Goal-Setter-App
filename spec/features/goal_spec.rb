require 'spec_helper'
require 'rails_helper'

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

  scenario "deletes a goal" do
    create_goal_as_scott_bot
    click_link("eat apples")
    click_button("Delete")
    expect(page).to_not have_content("eat apples")
  end

  scenario "scott_bot cannot access private links of other user" do
    create_p_goal_as_jake_bot
    click_button("Sign Out")
    sign_in_as_scott_bot
    visit user_url(1)
    expect(page).to_not have_content("eat honey")
  end

  scenario "goals can be completed" do
    create_p_goal_as_jake_bot
    click_link("eat honey")
    click_link("Edit")
    check('Completed')
    click_button("Update")
    click_link("eat honey")
    expect(page).to have_content("Completed")
  end
end
