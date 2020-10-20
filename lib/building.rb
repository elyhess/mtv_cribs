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

  def renter_with_highest_rent
    highest_paying = rented_units.max_by do |unit|
      unit.monthly_rent
    end
    highest_paying.renter
  end

  def units_by_number_of_bedrooms
    units_by_bedroom = Hash.new {|hash, key| hash[key] = []}
    @units.each do |unit|
      units_by_bedroom[unit.bedrooms] << unit.number
    end
    units_by_bedroom
  end

  def annual_breakdown
    annual_breakdown = Hash.new {|hash, key| hash[key] = 0}
    @units.each do |unit|
      if unit.renter != nil
        annual_breakdown[unit.renter.name] += unit.monthly_rent * 12
      end
    end
    annual_breakdown
  end

  def bedrooms_bathrooms
    bedrooms_bathrooms = Hash.new {|hash, key| hash[key] = 0}
    rented_units.each do |unit|
      bedrooms_bathrooms[:bathrooms] = unit.bathrooms
      bedrooms_bathrooms[:bedrooms] = unit.bedrooms
    end
    bedrooms_bathrooms
  end

  def rooms_by_renter
    rooms_by_renter = Hash.new {|hash, key| hash[key] = {}}
    @units.each do |unit|
      if unit.renter != nil
        rooms_by_renter[unit.renter] = bedrooms_bathrooms
      end
    end
    rooms_by_renter
  end


end
