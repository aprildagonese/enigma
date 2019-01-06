require './lib/enigma'
require './lib/date'

class Key
  attr_reader :key_string

  def initialize(key_string = nil)
    @key_string = key_string
  end

  def generate_random_key
    random_key = ""
    5.times do
      random_key += rand(0..9).to_s
    end
    @key_string = random_key.rjust(5, "0")
  end

  def key_shifts
    key_shifts = {  :A => @key_string[0] + @key_string[1],
                    :B => @key_string[1] + @key_string[2],
                    :C => @key_string[2] + @key_string[3],
                    :D => @key_string[3] + @key_string[4] }
  end

end
