require "spec_helper"

feature "Update a location's phone numbers" do
  background do
    login_admin
  end

  scenario "when location doesn't have any phone numbers" do
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='number[]']")
  end

  scenario "by adding a new number", :js => true do
    visit_location_with_no_phone
    add_phone_number
    visit_location_with_no_phone
    find_field('number[]').value.should eq "7035551212"
    find_field('vanity_number[]').value.should eq "703555-ABCD"
    find_field('extension[]').value.should eq "x1223"
    find_field('department[]').value.should eq "CalFresh"
    delete_phone_number
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='number[]']")
  end

  scenario "with an invalid phone number" do
    visit_test_location
    fill_in "number[]", with: "703"
    click_button "Save changes"
    expect(page).to have_content "Please enter a valid US phone number"
  end

  scenario "with a valid phone number" do
    visit_test_location
    fill_in "number[]", with: "7035551212"
    click_button "Save changes"
    visit_test_location
    find_field('number[]').value.should eq "7035551212"
  end

  scenario "with 2 phones but one is empty", :js => true do
    visit_test_location # it already has one
    click_link "Add a new number"
    click_button "Save changes"
    visit_test_location
    total_phones = page.
      all(:xpath, "//input[@type='text' and @name='number[]']")
    total_phones.length.should eq 1
  end
end