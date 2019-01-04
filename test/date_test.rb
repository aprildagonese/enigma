require 'simplecov'
SimpleCov.start
require './lib/date'
require 'minitest/autorun'
require 'minitest/pride'

class DateTest < Minitest::Test

  def test_it_exists
    assert_instance_of Date, Date.new
  end




end
