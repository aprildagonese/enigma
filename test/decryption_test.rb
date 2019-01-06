require 'simplecov'
SimpleCov.start
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/decryption'
require 'pry'

class DecryptionTest < Minitest::Test

  def setup
    @decryption = Decryption.new
    @decryption2 = Decryption.new
  end

  def test_it_exists
    assert_instance_of Decryption, @decryption
  end

  def test_it_decodes_cyphertext
    decryption1 = Decryption.new
    decryption1.decrypt("krgt", "01234", "101183")
    decryption2 = Decryption.new
    decryption2.decrypt("lspiuftg", "88888", "101183")
    decryption3 = Decryption.new
    decryption3.decrypt("@cgx0wt!", "88888", "101183")

    assert_equal "abcd", decryption1.decode_ciphertext("krgt")
    assert_equal "whatever", decryption2.decode_ciphertext("lspiuftg")
    assert_equal "@ssh0le!", decryption3.decode_ciphertext("@cgx0wt!")
  end

end
