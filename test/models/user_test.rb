require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Cannot save user with short length of password" do
    user = User.new
    user.username = "test1"
    user.email = "testing@testing.com"
    user.password = "123456"
    user.activated = true
    assert_not user.save
  end

  test "Email format has to be valid" do
    user = User.new
    user.username = "test2"
    user.email = "testing"
    user.password = "12345678"
    user.activated = true
    assert_not user.save
  end
  
  test "Cannot save user with duplicate email" do
    user = User.new
    user.username = "test3"
    user.email = "testing@testing.com"
    user.password = "12345678"
    user.activated = true
    user.save

    user2 = User.new
    user2.username = "test4"
    user2.email = "testing@testing.com"
    user2.password = "11111111"
    user2.activated = true
    assert_not user2.save
  end

end
