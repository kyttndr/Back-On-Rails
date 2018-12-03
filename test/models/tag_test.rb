require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  #
  def setup
    @tag = Tag.new(name: "games")
  end

  test "tag should be valid" do
    assert @tag.valid?
  end

  test "name should be present" do
    @tag.name = " "
    assert_not @tag.valid?
  end

  test "name should be unique" do
    @tag.save
    tag2 = Tag.new(name: "games")
    assert_not tag2.valid?
  end

  test "name should not be too long" do
    @tag.name = "a" * 26
    assert_not @tag.valid?
  end

  test "name should not be too short" do
    @tag.name = "aa"
    assert_not @tag.valid?
  end
end

