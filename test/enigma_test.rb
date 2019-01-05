require 'simplecov'
SimpleCov.start
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_initializes_with_alphabet
    expected = ["NOPE", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, @enigma.alphabet
  end

  def test_encryption_key_and_date_given
    enigma1 = Enigma.new
    expected =  { :encryption => "lspiuftg",
                  :key => "88888",
                  :date => "101183"
                }
    assert_equal expected, enigma1.encrypt("whatever", key: "88888", date: "101183")
  end

  def test_encrytion_random_key_stored
    enigma1 = Enigma.new
    encryption1 = enigma1.encrypt("whatever", date: "101183")
    encryption2 = enigma1.encrypt("whatever", date: "141084")

    assert_equal 5, encryption1[:key].length
    assert_equal "101183", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "141084", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_encryption_current_date_stored
    enigma1 = Enigma.new
    encryption1 = enigma1.encrypt("whatever", key: "12345")
    encryption2 = enigma1.encrypt("whatever", key: "67890")

    assert_equal "040119", encryption1[:date]
    assert_equal "040119", encryption2[:date]
  end

  def test_encryption_no_key_or_date_given
    enigma1 = Enigma.new
    encryption1 = enigma1.encrypt("whatever")
    encryption2 = enigma1.encrypt("whatever")

    assert_equal 5, encryption1[:key].length
    assert_equal "040119", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "040119", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_it_calculates_shift
    enigma1 = Enigma.new
    enigma1.encrypt("whatever", key: "01234", date: "101183")

    assert_equal [10, 16, 31, 43], enigma1.calculate_shift
  end

  def test_it_encodes_message
    enigma1 = Enigma.new
    enigma1.encrypt("abcd", key: "01234", date: "101183")
    enigma1.calculate_shift

    assert_equal "krgt", enigma1.encode_message("abcd")
  end

end
