require 'simplecov'
SimpleCov.start
require './lib/key'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class KeyTest < Minitest::Test

  def setup
    @key = Key.new("01234")
  end

  def test_it_exists
    assert_instance_of Key, @key
  end



end
