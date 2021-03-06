require './lib/shifts'
require './lib/crack_key'
require './lib/encryption'
require './lib/decryption'

class Enigma
  include Shifts, Encryption, Decryption, Crack

  attr_accessor :key_string, :date_string, :shift

  def initialize
    @key_string = ""
    @date_string = ""
  end

  def encrypt(message, key = nil, date = nil)
    set_up_enigma(date)
    set_up_shift(key)
    encrypt_package(message)
  end

  def decrypt(message, key = nil, date = nil)
    set_up_enigma(date)
    set_up_shift(key)
    decrypt_package(message, key, date)
  end

  def crack(message, date = nil)
    set_up_enigma(date)
    crack_package(message, date)
  end

  def set_up_enigma(date = nil)
    @alphabet = (("a".."z").to_a << " ")
    @date_string = set_date(date)
  end

  def set_up_shift(key = nil)
    @key_string = set_key(key)
    @shift = calculate_shift(@key_string, @date_string)
  end

end
