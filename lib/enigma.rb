require './lib/key'
require './lib/date'
require './lib/crack'

class Enigma
  include Crack
  #decrypt
  #CLI
  #cracking

  def initialize
    @alphabet = (("a".."z").to_a << " ").unshift("NOPE")
  end

  def encrypt(message, key: nil, date: nil)
    @key_object = Key.new(key)
    @dateid_object = DateID.new(date)
    calculate_shift
    ecryption = { :encryption => encode_message(message),
                  :key => @key_object.key_string,
                  :date => @dateid_object.date_string }
  end

  def calculate_shift
    keys = @key_object.key_shifts
    dates = @dateid_object.date_offsets

    @shift = keys.map do |key, value|
      value.to_i + dates[key].to_i
    end
  end

  def encode_message(message)
    new_chars = []
    message.downcase.split("").each do |char|
      new_index = (@alphabet.find_index(char) + @shift[0]) % 27
      new_chars << @alphabet[new_index]
      @shift = @shift.rotate
    end
    new_chars.join
  end

  def decrypt(ciphertext, key: nil, date: nil)
    @dateid_object = DateID.new(date)
    @ciphertext = ciphertext
    create_key_object(key)
    decryption = { :decryption => decode_ciphertext(ciphertext),
                   :key => @key_object.key_string,
                   :date => @dateid_object.date_string }
  end

  def create_key_object(key)
    if key == nil
      @key_object = Key.new(calculate_key)
    else
      @key_object = Key.new(key)
    end
  end

  def decode_ciphertext(ciphertext)
    calculate_shift
    new_chars = []
    ciphertext.downcase.split("").each do |char|
      difference = @alphabet.find_index(char) - (@shift[0] % 27)
      if difference > 0
        new_index = difference
      else
        new_index = 27 - difference.abs
      end
      new_chars << @alphabet[new_index]
      @shift = @shift.rotate
    end
    new_chars.join
  end

end
