require 'minitest/autorun'           # => true
require 'minitest/pride'             # => true
require_relative '../lib/renter'     # => true
require_relative '../lib/apartment'  # => true
require_relative '../lib/building'   # => true

class BuildingTest < Minitest::Test  # => Minitest::Test

  def test_it_exists_and_has_attributes
    building = Building.new              # => #<Building:0x00007ff65d95a640 @units=[]>

    assert_equal [], building.units  # => true
  end                                # => :test_it_exists_and_has_attributes

  def test_it_adds_units
    building = Building.new                                                               # => #<Building:0x00007ff66002d290 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff66002cf20 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff66002cb38 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>

    building.add_unit(unit1)  # => [#<Apartment:0x00007ff66002cf20 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007ff66002cf20 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66002cb38 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [unit1, unit2], building.units  # => true
  end                                            # => :test_it_adds_units

  def test_it_can_add_renter
    building = Building.new                                                               # => #<Building:0x00007ff65d962a98 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff65d961e90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff65d961788 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007ff65d961008 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007ff65d960c20 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007ff65d961e90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007ff65d961e90 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff65d961788 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit1.add_renter(renter1)                  # => #<Renter:0x00007ff65d961008 @name="Aurora">
    assert_equal ["Aurora"], building.renters  # => true

    unit2.add_renter(renter2)                         # => #<Renter:0x00007ff65d960c20 @name="Tim">
    assert_equal ["Aurora", "Tim"], building.renters  # => true
  end                                                 # => :test_it_can_add_renter

  def test_it_can_average_rent
    building = Building.new                                                               # => #<Building:0x00007ff660058008 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff66002fb58 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff66002ed70 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Aurora")                                                        # => #<Renter:0x00007ff66002e9d8 @name="Aurora">
    renter2 = Renter.new("Tim")                                                           # => #<Renter:0x00007ff66002e618 @name="Tim">
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007ff66002fb58 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007ff66002fb58 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66002ed70 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal 1099.5, building.average_rent  # => true
  end                                           # => :test_it_can_average_rent

  def test_it_shows_rented_units
    building = Building.new                                                               # => #<Building:0x00007ff6600476e0 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff6600472d0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff660046e20 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})  # => #<Apartment:0x00007ff6600469c0 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})  # => #<Apartment:0x00007ff6600465d8 @number="D4", @monthly_rent=1500, @bathrooms=2, @bedrooms=3, @renter=nil>
    renter1 = Renter.new("Spencer")                                                       # => #<Renter:0x00007ff660046268 @name="Spencer">

    building.add_unit(unit1)  # => [#<Apartment:0x00007ff6600472d0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007ff6600472d0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff660046e20 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit3)  # => [#<Apartment:0x00007ff6600472d0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff660046e20 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff6600469c0 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>]

    assert_equal [], building.rented_units  # => true

    unit2.add_renter(renter1)  # => #<Renter:0x00007ff660046268 @name="Spencer">

    assert_equal [unit2], building.rented_units  # => true
  end                                            # => :test_it_shows_rented_units

  def test_it_gives_highest_renter
    building = Building.new                                                               # => #<Building:0x00007ff6600372b8 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff660036ed0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff660036b10 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})  # => #<Apartment:0x00007ff660036660 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})  # => #<Apartment:0x00007ff660036278 @number="D4", @monthly_rent=1500, @bathrooms=2, @bedrooms=3, @renter=nil>
    renter1 = Renter.new("Spencer")                                                       # => #<Renter:0x00007ff660035eb8 @name="Spencer">
    renter2 = Renter.new("Jessie")                                                        # => #<Renter:0x00007ff660035b98 @name="Jessie">
    renter3 = Renter.new("Max")                                                           # => #<Renter:0x00007ff6600358a0 @name="Max">

    building.add_unit(unit1)  # => [#<Apartment:0x00007ff660036ed0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007ff660036ed0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff660036b10 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit3)  # => [#<Apartment:0x00007ff660036ed0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff660036b10 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff660036660 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit2.add_renter(renter1)                                # => #<Renter:0x00007ff660035eb8 @name="Spencer">
    assert_equal renter1, building.renter_with_highest_rent  # => true

    unit1.add_renter(renter2)                                # => #<Renter:0x00007ff660035b98 @name="Jessie">
    assert_equal renter2, building.renter_with_highest_rent  # => true

    unit3.add_renter(renter3)                                # => #<Renter:0x00007ff6600358a0 @name="Max">
    assert_equal renter2, building.renter_with_highest_rent  # => true
  end                                                        # => :test_it_gives_highest_renter

  def test_it_gives_units_by_number_of_bedrooms
    building = Building.new                                                               # => #<Building:0x00007ff66001fc58 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff66001f1e0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff66001e5d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})  # => #<Apartment:0x00007ff66001d9f8 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})  # => #<Apartment:0x00007ff66001cdf0 @number="D4", @monthly_rent=1500, @bathrooms=2, @bedrooms=3, @renter=nil>
    building.add_unit(unit1)                                                              # => [#<Apartment:0x00007ff66001f1e0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)                                                              # => [#<Apartment:0x00007ff66001f1e0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66001e5d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit3)                                                              # => [#<Apartment:0x00007ff66001f1e0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66001e5d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff66001d9f8 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit4)                                                              # => [#<Apartment:0x00007ff66001f1e0 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66001e5d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff66001d9f8 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff66001cdf0 @number="D4", @monthly_rent=1500, @bathrooms=2, @bedr...

    expected =
     {
       3 => ["D4" ],       # => ["D4"]
       2 => ["B2", "C3"],  # => ["B2", "C3"]
       1 => ["A1"]         # => ["A1"]
     }                     # => {3=>["D4"], 2=>["B2", "C3"], 1=>["A1"]}

    assert_equal expected, building.units_by_number_of_bedrooms  # => true
  end                                                            # => :test_it_gives_units_by_number_of_bedrooms

  def test_it_gives_annual_breakdown
    building = Building.new                                                               # => #<Building:0x00007ff66003feb8 @units=[]>
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})  # => #<Apartment:0x00007ff66003fb98 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})   # => #<Apartment:0x00007ff66003f7d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})  # => #<Apartment:0x00007ff66003f2b0 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>
    renter1 = Renter.new("Spencer")                                                       # => #<Renter:0x00007ff66003ec48 @name="Spencer">
    renter2 = Renter.new("Jessie")                                                        # => #<Renter:0x00007ff66003e838 @name="Jessie">

    building.add_unit(unit1)  # => [#<Apartment:0x00007ff66003fb98 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>]
    building.add_unit(unit2)  # => [#<Apartment:0x00007ff66003fb98 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66003f7d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>]
    building.add_unit(unit3)  # => [#<Apartment:0x00007ff66003fb98 @number="A1", @monthly_rent=1200, @bathrooms=1, @bedrooms=1, @renter=nil>, #<Apartment:0x00007ff66003f7d8 @number="B2", @monthly_rent=999, @bathrooms=2, @bedrooms=2, @renter=nil>, #<Apartment:0x00007ff66003f2b0 @number="C3", @monthly_rent=1150, @bathrooms=2, @bedrooms=2, @renter=nil>]

    unit2.add_renter(renter1)  # => #<Renter:0x00007ff66003ec48 @name="Spencer">

    expected = {"Spencer" => 11988}                   # => {"Spencer"=>11988}
    assert_equal expected, building.annual_breakdown  # => true

    unit1.add_renter(renter2)  # => #<Renter:0x00007ff66003e838 @name="Jessie">

    expected = {"Jessie" => 14400, "Spencer" => 11988}  # => {"Jessie"=>14400, "Spencer"=>11988}
    assert_equal expected, building.annual_breakdown    # => true
  end                                                   # => :test_it_gives_annual_breakdown




end  # => :test_it_gives_annual_breakdown

# >> Run options: --seed 26676
# >>
# >> # Running:
# >>
# >> ........
# >>
# >> Finished in 0.002469s, 3240.1783 runs/s, 5265.2897 assertions/s.
# >>
# >> 8 runs, 13 assertions, 0 failures, 0 errors, 0 skips
