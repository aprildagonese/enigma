require './lib/key'
require './lib/date'

class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def load_file(file)
  end

  def encrypt(message, key: nil, date: nil)
    @key_object = Key.new(key)
    @dateid_object = DateID.new(date)

    ecryption = { :encryption => "placeholder",
                  :key => @key_object.key_string,
                  :date => @dateid_object.date_string
                }
  end

  def calculate_shift
    key_shifts = @key_object.key_shifts
    date_offsets = @dateid_object.date_offsets

  end

  def decrypt(ciphertext, key, date)
    :decryption
    :key
    :date
  end

end
