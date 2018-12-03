require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "setup_admin page should be disabled is admin already exist" do
    user = User.new
    user.username = "jason"
    user.email = "jasonzhao1219@gmail.com"
    user.password = "12345678"
    user.activated = true
    user.admin = true
    user.save

    get setup_admin_path
    
    assert_response :success
  end
end
