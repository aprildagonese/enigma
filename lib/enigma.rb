require './lib/key'
require './lib/date'
require './lib/crack'

class Enigma
  include Crack

  #fix arg headers for data and key
  #fix NOPEs in alphabet
  #finish crack
  #add mocks and stubs
  #add class method
  #refactor decrypt w/splat

  attr_reader :encrypted, :decrypted, :text,

  def initialize
  end

  def set_up_enigma(key, date)
    @alphabet = (("a".."z").to_a << " ").unshift("NOPE")
    @dateid_object = DateID.new(date)
    create_key_object(key)
  end

  def create_key_object(key)
    if key == nil
      if caller_locations[1].label == "encrypt"
        @key_object = Key.new.generate_random_key
      elsif caller_locations[1].label == "decrypt"
        @key_object = Key.new(calculate_key)
      else
        "Caller location was #{caller_locations[1]}"
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
    @encrypted = Encryption.new.encrypt(message, key, date)
  end

  def decrypt(message, key = nil, date = nil)
    @decrypted = Decryption.new.decrypt(message, key, date)
  end

end
