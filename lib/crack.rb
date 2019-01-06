module Crack

  def cracktest
    "THIS MODULE WORKS!"
  end

  def calculate_key
    split_chars = @ciphertext.split("")
    split_chars.each do |char|
      @alphabet.find_index(char)
    end

  end

  def find_date_rotation(ciphertext)
    rotation_count = ciphertext.length % 4
    date_shifts = @dateid_object.date_offsets.values
    rotation_count.times do
      date_shifts = date_shifts.rotate
    end
    date_shifts
  end

  def calculate_key_chars
    control = " end".split("")
    last_four_chars = @ciphertext.split("")[-4..-1]
    (0..3).map do |i|
    end
  end

end
