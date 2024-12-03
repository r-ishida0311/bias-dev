require "application_system_test_case"

class AppliesTest < ApplicationSystemTestCase
  setup do
    @apply = applies(:one)
  end

  test "visiting the index" do
    visit applies_url
    assert_selector "h1", text: "Applies"
  end

  test "should create apply" do
    visit applies_url
    click_on "New apply"

    click_on "Create Apply"

    assert_text "Apply was successfully created"
    click_on "Back"
  end

  test "should update Apply" do
    visit apply_url(@apply)
    click_on "Edit this apply", match: :first

    click_on "Update Apply"

    assert_text "Apply was successfully updated"
    click_on "Back"
  end

  test "should destroy Apply" do
    visit apply_url(@apply)
    click_on "Destroy this apply", match: :first

    assert_text "Apply was successfully destroyed"
  end
end
