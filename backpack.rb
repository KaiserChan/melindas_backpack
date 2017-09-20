class Backpack
  def initialize(attributes)
    @attributes = attributes # a hash containing day_of_week and weather keys
    @items = []
    prepare
  end

  def items
    @items
  end

  def prepare
    # set up local variables used by rest of prepare method
    weather_of_the_day = @attributes[:weather]
    day_of_week = @attributes[:day_of_week]

    # Ensure appropriate clothing is added to backpack
    backpack_per_weather(weather_of_the_day)

    # Ensure gym shoes are added to backpack if it's a gym day
    backpack_per_gym_schedule(day_of_week)

    # Bring a packed lunch on all weekdays
    backpack_per_weekdays(day_of_week)

  end

  # Prints a summary packing list for Melinda's backpack
  def backpack_of_the_day
    output = []
    output << "Melinda, here's your packing list!"
    output << "Day: #{@attributes[:day_of_week]}, Weather: #{@attributes[:weather]}"
    output << ""

    @items.each do |item|
      output << "- #{item}"
    end
    output.join("\n")
  end

  def regular_days_items
    @items << 'pants'
    @items << 'shirt'
  end

  def rainy_days_items
    regular_days_items
    @items << 'umbrella'
  end

  def cold_days_items
    regular_days_items
    @items << 'jacket'
  end

  def gym_days
    day_of_week = @attributes[:day_of_week]
    day_of_week == 'monday' || day_of_week == 'thursday'
  end

  def weekdays
    day_of_week = @attributes[:day_of_week]
    day_of_week != 'saturday' && day_of_week != 'sunday'
  end

  def backpack_per_weather(weather)
    if weather == 'rainy'
      rainy_days_items
    elsif weather == 'cold'
      cold_days_items
    else
      regular_days_items
    end
  end

  def backpack_per_gym_schedule(day)
    if gym_days
      @items << 'gym shoes'
    end
  end

  def backpack_per_weekdays(day)
    if weekdays
      @items << 'packed lunch'
    else
      @items << 'snacks'
    end
  end

end

melindas = Backpack.new(day_of_week: 'thursday', weather: 'rainy')
puts melindas.backpack_of_the_day
