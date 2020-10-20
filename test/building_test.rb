require 'minitest/autorun'           # => true
require 'minitest/pride'             # => true
require_relative '../lib/renter'     # => true
require_relative '../lib/apartment'  # => true
require_relative '../lib/building'   # => true

class BuildingTest < Minitest::Test  # => Minitest::Test

  def test_it_exists_and_has_attributes
    building = Building.new              # => #<Building:0x00007ff79708dce8 @units=[]>

    assert_equal [], building.units  # => true
  end                                # => :test_it_exists_and_has_attributes

  def test_it_adds_units
    building = Building.new                                                               # => #<Building:0x00007ff797086d80 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff797086a38 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff797086650 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>

    building.add_unit(unit1)  # => [#<Apartment:0x00007ff797086a38 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007ff797086a38 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff797086650 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [unit1, unit2], building.units  # => true
  end                                            # => :test_it_adds_units

  def test_it_can_add_renter
    building = Building.new                                                               # => #<Building:0x00007ff79488c9b0 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff79488c410 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff79708fe80 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007ff79708fae8 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007ff79708f818 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007ff79488c410 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007ff79488c410 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff79708fe80 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit1.add_renter(renter1)                  # => #<Renter:0x00007ff79708fae8 @name="Aurora">
    assert_equal ["Aurora"], building.renters  # => true

    unit2.add_renter(renter2)                         # => #<Renter:0x00007ff79708f818 @name="Tim">
    assert_equal ["Aurora", "Tim"], building.renters  # => true
  end                                                 # => :test_it_can_add_renter

  def test_it_can_average_rent
    building = Building.new                                                               # => #<Building:0x00007ff79708d4f0 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff79708d180 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff79708cdc0 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007ff79708ca50 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007ff79708c780 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007ff79708d180 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007ff79708d180 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff79708cdc0 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal 1099.5, building.average_rent  # => true
  end                                           # => :test_it_can_average_rent



end  # => :test_it_can_average_rent

# >> Run options: --seed 28386
# >>
# >> # Running:
# >>
# >> ....
# >>
# >> Finished in 0.001643s, 2434.5710 runs/s, 3043.2137 assertions/s.
# >>
# >> 4 runs, 5 assertions, 0 failures, 0 errors, 0 skips
