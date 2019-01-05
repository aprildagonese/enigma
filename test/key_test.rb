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

  def test_it_initializes_with_given_key
    assert_equal "01234", @key.key_string
  end

  def test_it_generates_random_5_digit_key
    key_a = Key.new.key_string
    key_b = Key.new.key_string

    assert_equal String, key_a.class
    assert_equal 5, key_a.length
    assert_equal 5, key_b.length
    assert_equal false, key_a == key_b
  end

  def test_it_splits_key_into_keys
    expected = { :A => "01",
                 :B => "12",
                 :C => "23",
                 :D => "34" }
    assert_equal expected, @key.key_shifts
  end

end
