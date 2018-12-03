require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  test "Cannot build friendship with yourself" do
    user = User.new
    user.username = "test"
    user.email = "testing@testing.com"
    user.password = "12345678"
    user.activated = true

    user.save
  
    assert_not(user.friends << user)
  end
  
end
