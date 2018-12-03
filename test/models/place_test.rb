require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Cannot save place with no address" do
    place = Place.new
    assert_not place.save
  end

  test "Cannot save place with invalid address" do
    place = Place.new
    place.address = "adsjfaklsjfasnaldjaskldcj"
    assert_not place.save
  end

end
