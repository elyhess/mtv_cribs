require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/renter'

class RenterTest < Minitest::Test

  def test_it_exists_and_has_attributes
    renter1 = Renter.new("Jessie")

    assert_equal "Jessie", renter1.name
  end

end
