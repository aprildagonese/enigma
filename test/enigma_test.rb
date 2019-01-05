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

  def test_encryption_key_and_date_given
    enigma1 = Enigma.new
    expected =  { :encryption => "lspiuftg",
                  :key => "88888",
                  :date => "101183" }
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

    assert_equal "050119", encryption1[:date]
    assert_equal "050119", encryption2[:date]
  end

  def test_encryption_no_key_or_date_given
    enigma1 = Enigma.new
    encryption1 = enigma1.encrypt("whatever")
    encryption2 = enigma1.encrypt("whatever")

    assert_equal 5, encryption1[:key].length
    assert_equal "050119", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "050119", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_it_calculates_shift
    enigma1 = Enigma.new
    enigma1.encrypt("whatever", key: "01234", date: "101183")
    enigma2 = Enigma.new
    enigma2.encrypt("whatever", key: "90037", date: "130385")

    assert_equal [10, 16, 31, 43], enigma1.calculate_shift
    assert_equal [98, 2, 5, 42], enigma2.calculate_shift
  end

  def test_it_encodes_message
    enigma1 = Enigma.new
    enigma1.encrypt("abcd", key: "01234", date: "101183")
    enigma1.calculate_shift

    assert_equal "krgt", enigma1.encode_message("ABCD")
  end

  def test_it_decodes_cyphertext
    enigma1 = Enigma.new
    enigma1.decrypt("krgt", key: "01234", date: "101183")
    enigma2 = Enigma.new
    enigma2.decrypt("lspiuftg", key: "88888", date: "101183")

    assert_equal "abcd", enigma1.decode_ciphertext("krgt")
    assert_equal "whatever", enigma2.decode_ciphertext("lspiuftg")
  end

  def test_decryption_key_and_date_given
    enigma1 = Enigma.new
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, enigma1.decrypt("lspiuftg", key: "88888", date: "101183")
  end

  def test_decryption_no_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "050119" }
    assert_equal expected, @enigma.decrypt("gpnapcrz", key: "88888")
  end

  def test_crack_module
    assert_equal "THIS MODULE WORKS!", @enigma.cracktest
  end 

end
