require "spec_helper"

feature "Update a service's service areas" do
  background do
    login_admin
  end

  scenario "when service doesn't have any service areas" do
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='service_areas[]']")
  end

  scenario "by adding 2 new service_areas", :js => true do
    visit_location_with_no_phone
    add_two_service_areas
    visit_location_with_no_phone
    expect(page).to have_link "Delete this service area permanently"
    delete_all_service_areas
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='service_areas[]']")
  end

  scenario "with empty service area", :js => true do
    visit_test_location
    fill_in "service_areas[]", with: ""
    click_button "Save changes"
    visit_test_location
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='service_areas[]']")
    add_service_area
  end

  scenario "with 2 service_areas but one is empty", :js => true do
    visit_test_location # it already has one
    click_link "Add a new service area"
    click_button "Save changes"
    visit_test_location
    total_service_areas = page.
      all(:xpath, "//input[@type='text' and @name='service_areas[]']")
    total_service_areas.length.should eq 1
  end

  scenario "with invalid service area" do
    visit_test_location
    fill_in "service_areas[]", with: "Belmont, CA"
    click_button "Save changes"
    expect(page).to have_content "At least one service area is improperly
      formatted, or is not an accepted city or county name. Please make sure
      all words are capitalized."
  end

  scenario "with valid service area" do
    visit_test_location
    fill_in "service_areas[]", with: "San Mateo County"
    click_button "Save changes"
    visit_test_location
    find_field('service_areas[]').value.should eq "San Mateo County"
  end
end