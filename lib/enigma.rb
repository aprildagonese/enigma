require './lib/key'
require './lib/date'
require './lib/crack'

class Enigma
  include Crack

  #fix NOPEs in alphabet
  #finish crack
  #add mocks and stubs
  #add class method
  #refactor decrypt w/splat

  attr_reader :encryption, :decryption, :text
  attr_accessor :dateid_object, :key_object

  def initialize
    @key_object = ""
    @dateid_object = ""
  end

  def set_up_enigma(key, date)
    @alphabet = (("a".."z").to_a << " ").unshift("NOPE")
    @dateid_object = DateID.new(date)
    create_key_object(key)
  end

  def create_key_object(key)
    caller = caller_locations[1].label
    if key == nil
      if caller == "encrypt"
        @key_object = Key.new
        @key_object.generate_random_key
      elsif caller == "decrypt"
        @key_object = Key.new(calculate_key)
      else
        @key_object = "ERROR"
      end
    else
      @key_object = Key.new(key)
    end
  end

  def calculate_shift
    keys = @key_object.key_shifts
    dates = @dateid_object.date_offsets

    @shift = keys.map do |key, value|
      value.to_i + dates[key].to_i
    end
  end

  def encrypt(message, key = nil, date = nil)
    @encryption = Encryption.new
    @encryption.encrypt(message, key, date)

  end

  def decrypt(message, key = nil, date = nil)
    @decryption = Decryption.new
    @decryption.decrypt(message, key, date)
  end

end
