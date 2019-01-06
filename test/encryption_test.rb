require 'simplecov'
SimpleCov.start
require './lib/enigma'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption'
require 'pry'

class EncryptionTest < Minitest::Test

  def setup
    @encryption = Encryption.new
    @encryption2 = Encryption.new
  end

  def test_it_exists
    assert_instance_of Encryption, @encryption
  end

  def test_it_encodes_message
    @encryption.encrypt("abcd", "01234", "101183")

    assert_equal "krgt", @encryption.encode_message("ABCD")
  end

end
