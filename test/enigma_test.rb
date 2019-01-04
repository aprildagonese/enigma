require 'simplecov'
SimpleCov.start
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'

class EnigmaTest < Minitest::Test

  def test_it_exists
    assert_instance_of Enigma, Enigma.new
  end



end
