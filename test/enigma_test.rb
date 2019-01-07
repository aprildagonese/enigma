require 'simplecov'
SimpleCov.start
require './lib/enigma'
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

  def test_it_calculates_shift
    enigma1 = Enigma.new
    enigma1.encrypt("whatever", "01234", "101183")
    enigma2 = Enigma.new
    enigma2.encrypt("whatever", "90037", "130385")

    assert_equal [10, 16, 31, 43], enigma1.encryption.calculate_shift
    assert_equal [98, 2, 5, 42], enigma2.encryption.calculate_shift
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

  def test_encrytion_random_key_stored
    enigma1 = Enigma.new
    encryption1 = enigma1.encrypt("whatever")
    encryption2 = enigma1.encrypt("whatever")

    assert_equal 5, encryption1[:key].length
    assert_equal "060119", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "060119", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_encryption_current_date_stored
    enigma1 = Enigma.new
    encoded1 = enigma1.encrypt("whatever", "12345")
    encoded2 = enigma1.encrypt("whatever", "67890")

    assert_equal "060119", encoded1[:date]
    assert_equal "060119", encoded2[:date]
  end

  def test_encryption_no_key_or_date_given
    encryption1 = Encryption.new
    encoded1 = encryption1.encrypt("whatever")
    encoded2 = encryption1.encrypt("whatever")

    assert_equal 5, encoded1[:key].length
    assert_equal "060119", encoded1[:date]
    assert_equal 5, encoded2[:key].length
    assert_equal "060119", encoded2[:date]
    assert_equal false, encoded1[:key] == encoded2[:key]
  end

  def test_decryption_key_and_date_given
    enigma1 = Enigma.new
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, enigma1.decrypt("lspiuftg", "88888", "101183")
  end

  def test_decryption_no_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "060119" }
    assert_equal expected, @enigma.decrypt("gpnapcrz", "88888")
  end

  def test_crack_module
    assert_equal "THIS MODULE WORKS!", @enigma.cracktest
  end

  def test_it_finds_correct_date_rotation
    @enigma.decrypt("abcde", "00000", "101183")
    @enigma2.decrypt("abcdefghij", "00000", "101183")

    assert_equal ["4", "8", "9", "9"], @enigma.decryption.find_date_rotation("abcde")
    assert_equal ["8", "9", "9", "4"], @enigma2.decryption.find_date_rotation("abcdefghij")
  end



end
