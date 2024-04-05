require "test_helper"

class AdministratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = administrators(:one)
  end

  test "should get index" do
    get administrators_url, as: :json
    assert_response :success
  end

  test "should create administrator" do
    assert_difference("Administrator.count") do
      post administrators_url, params: { administrator: { email: @administrator.email, first_name: @administrator.first_name, last_name: @administrator.last_name } }, as: :json
    end

    assert_response :created
  end

  test "should show administrator" do
    get administrator_url(@administrator), as: :json
    assert_response :success
  end

  test "should update administrator" do
    patch administrator_url(@administrator), params: { administrator: { email: @administrator.email, first_name: @administrator.first_name, last_name: @administrator.last_name } }, as: :json
    assert_response :success
  end

  test "should destroy administrator" do
    assert_difference("Administrator.count", -1) do
      delete administrator_url(@administrator), as: :json
    end

    assert_response :no_content
  end
end
