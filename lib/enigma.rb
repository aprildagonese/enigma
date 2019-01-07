require './lib/shifts'
require './lib/crack'
require './lib/encryption'
require './lib/decryption'


#finish crack
#add mocks and stubs
#add class method
#refactor decrypt w/splat
#lines per method? chars per line?

class Enigma
  include Shifts, Encryption, Decryption

  attr_reader :encryption, :decryption, :crack
  attr_accessor :key_string, :date_string,

  def encrypt(message, key = nil, date = nil)
    set_up_enigma
    @encryption = Encryption.new
    @encryption.encrypt(message, key, date)

  end

  def decrypt(message, key = nil, date = nil)
    set_up_enigma
    @decryption = Decryption.new
    @decryption.decrypt(message, key, date)
  end

  def crack(message)
    set_up_enigma
    @crack = Crack.new
    @crack.crack(message)
  end

  def set_up_enigma(key, date)
    @alphabet = (("a".."z").to_a << " ")
    @date_string = set_date(date)
    @key_string = set_key(key)
    @shift = calculate_shift(@key, @date)
  end

end
