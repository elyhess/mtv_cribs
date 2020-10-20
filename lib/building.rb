class Building
  attr_reader :units, :renters

  def initialize
    @units = []
  end

  def add_unit(apartment)
    @units << apartment
  end

  def renters
    renters = []
    @units.map do |unit|
      if unit.renter != nil
        renters << unit.renter.name
      end
    end
    renters
  end

  def average_rent
    total_unit_price = 0
    @units.each do |unit|
      total_unit_price += unit.monthly_rent
    end
    total_unit_price / units.count.to_f
  end

  def rented_units
    @units.select do |unit|
      if unit.renter != nil
        renters << unit.renter
      end
    end
  end

end
