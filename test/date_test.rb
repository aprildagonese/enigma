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



end
