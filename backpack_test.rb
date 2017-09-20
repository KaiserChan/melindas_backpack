require 'minitest/autorun'
require 'minitest/pride'
require 'factory_girl'
require 'pry'

require './backpack.rb'
require './factories.rb'

class BackpackTest < MiniTest::Test

  include FactoryGirl::Syntax::Methods

  ##### TESTS ABOUT BRINGING THE RIGHT CLOTHING #####
  def test_that_always_has_pants_and_shirt
    backpack = build(:backpack)
    assert(backpack.items.include?('pants'))
    assert(backpack.items.include?('shirt'))
  end

  def test_that_brings_umbrella_when_rainy
    backpack = build(:backpack, weather: 'rainy')
    assert(backpack.items.include?('umbrella'))
  end

  def test_that_brings_jacket_when_cold
    backpack = build(:backpack, weather: 'cold')
    assert(backpack.items.include?('jacket'))
  end

  ##### TESTS ABOUT PACKED LUNCHES #####
  def test_that_packs_lunch_on_all_weekdays
    ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'].each do |day|
      backpack = build(:backpack, day_of_week: day)
      assert(backpack.items.include?('packed lunch'))
    end
  end

  def test_that_doesnt_pack_lunch_on_weekends
    ['saturday', 'sunday'].each do |day|
      backpack = build(:backpack, day_of_week: day)
      refute(backpack.items.include?('packed lunch'))
    end
  end


  ###### TESTS ABOUT GYM SHOES... wait, where are the tests about gym shoes? #####
  # is something missing here?
  def test_that_pack_gyms_shoes_on_gym_days
    ['monday', 'thursday'].each do |day|
      backpack = build(:backpack, day_of_week: day)
      assert(backpack.items.include?('gym shoes'))
    end
  end


  ##### TESTS ABOUT PRINTING THE LIST #####
  def test_that_backpack_prints_correctly
    backpack = build(:backpack, day_of_week: 'monday', weather: 'sunny')
    expected =
"Melinda, here's your packing list!
Day: monday, Weather: sunny

- pants
- shirt
- gym shoes
- packed lunch"
    assert_equal(backpack.backpack_of_the_day, expected)
  end

end
