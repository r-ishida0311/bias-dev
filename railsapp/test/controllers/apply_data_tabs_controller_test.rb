require "test_helper"

class ApplyDataTabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apply_data_tab = apply_data_tabs(:one)
  end

  test "should get index" do
    get apply_data_tabs_url
    assert_response :success
  end

  test "should get new" do
    get new_apply_data_tab_url
    assert_response :success
  end

  test "should create apply_data_tab" do
    assert_difference("ApplyDataTab.count") do
      post apply_data_tabs_url, params: { apply_data_tab: {  } }
    end

    assert_redirected_to apply_data_tab_url(ApplyDataTab.last)
  end

  test "should show apply_data_tab" do
    get apply_data_tab_url(@apply_data_tab)
    assert_response :success
  end

  test "should get edit" do
    get edit_apply_data_tab_url(@apply_data_tab)
    assert_response :success
  end

  test "should update apply_data_tab" do
    patch apply_data_tab_url(@apply_data_tab), params: { apply_data_tab: {  } }
    assert_redirected_to apply_data_tab_url(@apply_data_tab)
  end

  test "should destroy apply_data_tab" do
    assert_difference("ApplyDataTab.count", -1) do
      delete apply_data_tab_url(@apply_data_tab)
    end

    assert_redirected_to apply_data_tabs_url
  end
end
