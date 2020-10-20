class Building
  attr_reader :units, :renters  # => nil

  def initialize
    @units = []
  end             # => :initialize

  def add_unit(apartment)
    @units << apartment
  end                      # => :add_unit

  def renters
    renters = []
    @units.map do |unit|
      if unit.renter != nil
        renters << unit.renter.name
      end
    end
    renters
  end                         # => :renters

end  # => :renters
