require 'minitest/autorun'           # => true
require 'minitest/pride'             # => true
require_relative '../lib/renter'     # => true
require_relative '../lib/apartment'  # => true
require_relative '../lib/building'   # => true

class BuildingTest < Minitest::Test  # => Minitest::Test

  def test_it_exists_and_has_attributes
    building = Building.new              # => #<Building:0x00007fbf80832f10 @units=[]>

    assert_equal [], building.units  # => true
  end                                # => :test_it_exists_and_has_attributes

  def test_it_adds_units
    building = Building.new                                                               # => #<Building:0x00007fbf80838cf8 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fbf80838780 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fbf80838190 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>

    building.add_unit(unit1)  # => [#<Apartment:0x00007fbf80838780 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007fbf80838780 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fbf80838190 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [unit1, unit2], building.units  # => true
  end                                            # => :test_it_adds_units

  def test_it_can_add_renter
    building = Building.new                                                               # => #<Building:0x00007fbf80840ac0 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fbf80840598 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fbf808400c0 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007fbf8083bb38 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007fbf8083b688 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007fbf80840598 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007fbf80840598 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fbf808400c0 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit1.add_renter(renter1)                  # => #<Renter:0x00007fbf8083bb38 @name="Aurora">
    assert_equal ["Aurora"], building.renters  # => true

    unit2.add_renter(renter2)                         # => #<Renter:0x00007fbf8083b688 @name="Tim">
    assert_equal ["Aurora", "Tim"], building.renters  # => true

  end  # => :test_it_can_add_renter

end  # => :test_it_can_add_renter

# >> Run options: --seed 26502
# >>
# >> # Running:
# >>
# >> ...
# >>
# >> Finished in 0.000865s, 3468.2088 runs/s, 4624.2783 assertions/s.
# >>
# >> 3 runs, 4 assertions, 0 failures, 0 errors, 0 skips
