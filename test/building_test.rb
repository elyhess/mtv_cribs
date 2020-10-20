require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/renter'
require_relative '../lib/apartment'
require_relative '../lib/building'

class BuildingTest < Minitest::Test

  def test_it_exists_and_has_attributes
    building = Building.new

    assert_equal [], building.units
  end

end
