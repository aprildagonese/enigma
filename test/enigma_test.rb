require 'simplecov'
SimpleCov.start
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'

class EnigmaTest < Minitest::Test

  def test_it_exists
    assert_instance_of Enigma, Enigma.new
  end

  def test_it_loads_files
  end

  def test_it_encrypts_with_key_and_date_given
  end

  def test_it_encrypts_with_random_key_if_none_given
  end

  def test_it_encrypts_with_todays_date_if_none_given
  end

  def test_it_encrypts_with_random_key_and_todays_date
  end

  def test_it_decrypts_with_key_and_date_given
  end

  def test_it_decrypts_with_no_key_given
  end

  def test_it_decrypts_with_no_date_given
  end

  def test_it_decrypts_with_no_key_or_date_given
  end 

end
