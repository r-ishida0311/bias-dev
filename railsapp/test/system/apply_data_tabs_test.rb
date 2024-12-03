require "application_system_test_case"

class ApplyDataTabsTest < ApplicationSystemTestCase
  setup do
    @apply_data_tab = apply_data_tabs(:one)
  end

  test "visiting the index" do
    visit apply_data_tabs_url
    assert_selector "h1", text: "Apply data tabs"
  end

  test "should create apply data tab" do
    visit apply_data_tabs_url
    click_on "New apply data tab"

    click_on "Create Apply data tab"

    assert_text "Apply data tab was successfully created"
    click_on "Back"
  end

  test "should update Apply data tab" do
    visit apply_data_tab_url(@apply_data_tab)
    click_on "Edit this apply data tab", match: :first

    click_on "Update Apply data tab"

    assert_text "Apply data tab was successfully updated"
    click_on "Back"
  end

  test "should destroy Apply data tab" do
    visit apply_data_tab_url(@apply_data_tab)
    click_on "Destroy this apply data tab", match: :first

    assert_text "Apply data tab was successfully destroyed"
  end
end
