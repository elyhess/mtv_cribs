require 'minitest/autorun'           # => true
require 'minitest/pride'             # => true
require_relative '../lib/renter'     # => true
require_relative '../lib/apartment'  # => true
require_relative '../lib/building'   # => true

class BuildingTest < Minitest::Test  # => Minitest::Test

  def test_it_exists_and_has_attributes
    building = Building.new              # => #<Building:0x00007fec2812b5f8 @units=[]>

    assert_equal [], building.units  # => true
  end                                # => :test_it_exists_and_has_attributes

  def test_it_adds_units
    building = Building.new                                                               # => #<Building:0x00007fec281335c8 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fec28133258 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fec28132e20 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>

    building.add_unit(unit1)  # => [#<Apartment:0x00007fec28133258 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007fec28133258 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fec28132e20 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [unit1, unit2], building.units  # => true
  end                                            # => :test_it_adds_units

  def test_it_can_add_renter
    building = Building.new                                                               # => #<Building:0x00007fec2813a120 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fec28139d10 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fec28139888 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007fec281394f0 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007fec281391a8 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007fec28139d10 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007fec28139d10 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fec28139888 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit1.add_renter(renter1)                  # => #<Renter:0x00007fec281394f0 @name="Aurora">
    assert_equal ["Aurora"], building.renters  # => true

    unit2.add_renter(renter2)                         # => #<Renter:0x00007fec281391a8 @name="Tim">
    assert_equal ["Aurora", "Tim"], building.renters  # => true
  end                                                 # => :test_it_can_add_renter

  def test_it_can_average_rent
    building = Building.new                                                               # => #<Building:0x00007fec28131458 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fec28131110 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fec28130cd8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007fec281308f0 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007fec281305d0 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007fec28131110 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007fec28131110 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fec28130cd8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal 1099.5, building.average_rent  # => true
  end                                           # => :test_it_can_average_rent

  def test_it_shows_rented_units
    building = Building.new                                                               # => #<Building:0x00007fec2812adb0 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007fec2812aa90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007fec2812a6f8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})  # => #<Apartment:0x00007fec2812a1f8 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})  # => #<Apartment:0x00007fec28129dc0 @number="D4", @monthly_rent=1500, @bathrooms=2, @bedrooms=3, @renter=nil>
    renter1 = Renter.new("Spencer")                                                       # => #<Renter:0x00007fec28129a00 @name="Spencer">

    building.add_unit(unit1)  # => [#<Apartment:0x00007fec2812aa90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007fec2812aa90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fec2812a6f8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit3)  # => [#<Apartment:0x00007fec2812aa90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007fec2812a6f8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007fec2812a1f8 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [], building.rented_units  # => true

    unit2.add_renter(renter1)  # => #<Renter:0x00007fec28129a00 @name="Spencer">

    assert_equal [unit2], building.rented_units  # => true
  end                                            # => :test_it_shows_rented_units





end  # => :test_it_shows_rented_units

# >> Run options: --seed 68
# >>
# >> # Running:
# >>
# >> .....
# >>
# >> Finished in 0.001210s, 4132.2317 runs/s, 5785.1244 assertions/s.
# >>
# >> 5 runs, 7 assertions, 0 failures, 0 errors, 0 skips
