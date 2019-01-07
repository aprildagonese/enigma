require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/shifts'
require './lib/encryption'
require './lib/decryption'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @enigma2 = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_sets_given_key
    @enigma.set_up_shift("01234")
    assert_equal "01234", @enigma.key_string
  end

  def test_it_generates_random_5_digit_key
    key_a = @enigma.generate_random_key
    key_b = @enigma.generate_random_key

    assert_equal String, key_a.class
    assert_equal 5, key_a.length
    assert_equal 5, key_b.length
    assert_equal false, key_a == key_b
  end

  def test_it_splits_key_into_key_shifts
    expected = { :A => "01",
                 :B => "12",
                 :C => "23",
                 :D => "34" }

    assert_equal expected, @enigma.key_shifts("01234")
  end

  def test_it_sets_given_date
    @enigma.set_up_enigma("011118")

    assert_equal "011118", @enigma.date_string
  end

  def test_it_generates_todays_date
    @enigma.set_up_enigma

    assert_equal String, @enigma.date_string.class
    assert_equal 6, @enigma.date_string.length
  end

  def test_it_splits_date_into_offsets
    expected = { :A => "9",
                 :B => "9",
                 :C => "2",
                 :D => "4" }
    assert_equal expected, @enigma.date_offsets("111118")

    expected2 = { :A => "9",
                  :B => "4",
                  :C => "8",
                  :D => "9" }
    assert_equal expected2, @enigma.date_offsets("101183")
  end

  def test_it_calculates_shift

    assert_equal [10, 16, 31, 43], @enigma.calculate_shift("01234", "101183")
    assert_equal [98, 2, 5, 42], @enigma.calculate_shift("90037", "130385")
  end

  def test_it_encodes_message
    encryption = @enigma.encrypt("ABCD", "01234", "101183")

    assert_equal "krgt", encryption[:encryption]
  end

  def test_encryption_key_and_date_given
    expected =  { :encryption => "lspiuftg",
                  :key => "88888",
                  :date => "101183" }
    expected2 =  { :encryption => "lspiuftg!",
                   :key => "88888",
                   :date => "101183" }
    assert_equal expected, @enigma.encrypt("whatever", "88888", "101183")
    assert_equal expected2, @enigma2.encrypt("whatever!", "88888", "101183")
  end

  def test_encryption_no_key_or_date_given
    encryption1 = @enigma.encrypt("whatever")
    encryption2 = @enigma2.encrypt("whatever")

    assert_equal 5, encryption1[:key].length
    assert_equal "060119", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "060119", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_encryption_current_date_stored
    encoded1 = @enigma.encrypt("whatever", "12345")
    encoded2 = @enigma.encrypt("whatever", "67890")

    assert_equal "060119", encoded1[:date]
    assert_equal "060119", encoded2[:date]
  end

  def test_decryption_key_and_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, @enigma.decrypt("lspiuftg", "88888", "101183")
  end

  def test_decryption_no_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "060119" }
    assert_equal expected, @enigma.decrypt("gpnapcrz", "88888")
  end

  def test_it_finds_correct_date_rotation
    assert_equal ["4", "8", "9", "9"], @enigma.find_date_rotation("abcde", "101183")
    assert_equal ["8", "9", "9", "4"], @enigma2.find_date_rotation("abcdefghij", "101183")
  end

  def test_it_decodes_cyphertext
    decryption1 = @enigma.decrypt("krgt", "01234", "101183")
    decryption2 = @enigma.decrypt("lspiuftg", "88888", "101183")
    decryption3 = @enigma.decrypt("@cgx0wt!", "88888", "101183")

    assert_equal "abcd", decryption1[:decryption]
    assert_equal "whatever", decryption2[:decryption]
    assert_equal "@ssh0le!", decryption3[:decryption]
  end

end
