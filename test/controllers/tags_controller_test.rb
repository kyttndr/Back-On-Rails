require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @tag = Tag.create(name: "sports")
  end

  test "should get tags index" do
    get tags_path
    assert_response :success
  end

  test "should get new" do
    get new_tag_path
    assert_response :success
  end

  test "should get show" do
    get tag_path(@tag)
    assert_response :success
  end

end