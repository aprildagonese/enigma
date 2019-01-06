require 'simplecov'
SimpleCov.start
require './lib/date'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class DateTest < Minitest::Test

  def setup
    @date = DateID.new("011118")
    @date2 = DateID.new("101183")
  end

  def test_it_exists
    assert_instance_of DateID, @date
  end

  def test_it_initializes_with_given_date
    assert_equal "011118", @date.date_string
  end

  def test_it_generates_todays_date
    assert_equal String, @date.generate_todays_date.class
    assert_equal 6, @date.generate_todays_date.length
  end

  def test_it_initializes_with_todays_date
    date = DateID.new

    assert_equal "060119", date.date_string
  end

  def test_it_splits_date_into_offsets
    expected = { :A => "9",
                 :B => "9",
                 :C => "2",
                 :D => "4" }
    assert_equal expected, @date.date_offsets

    expected2 = { :A => "9",
                  :B => "4",
                  :C => "8",
                  :D => "9" }
    assert_equal expected2, @date2.date_offsets
  end

end
