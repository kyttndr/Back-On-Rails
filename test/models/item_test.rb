require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
    @user = User.first
    @item = Item.new(user_id: @user.id, name: "video game", description: "the game is very interesting", place_id: 1)
  end

  test "item should be valid" do
    assert @item.valid?
  end

  test "name should be present" do
    @item.name = " "
    assert_not @item.valid?
  end

  test "description should be present" do
    @item.description = " "
    assert_not @item.valid?
  end

  test "place should be present" do
    @item.place = nil
    assert_not @item.valid?
  end

  test "name don't need to be unique" do
    @item.save
    item2 = Item.new(user_id: @user.id, name: "video game", description: "the game is very interesting", place_id: 1)
    assert item2.valid?
  end

  test "name should not be too short" do
    @item.name = "aa"
    assert_not @item.valid?
  end

  test "description should not be too short" do
    @item.description = "a" * 9
    assert_not @item.valid?
  end
end
