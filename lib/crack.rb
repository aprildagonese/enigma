module Crack

  def cracktest
    "THIS MODULE WORKS!"
  end

  def calculate_key
    @split_chars = @ciphertext.split("")
    split_chars.each do |char|
      @alphabet.find_index(char)
    end

  end

  def find_date_rotation
    rotation_count = @ciphertext.length % 4
    date_shifts = @dateid_object.date_offsets.values
    rotation_count.times do
      date_shifts.rotate
    end
    rotated_date_shifts
    binding.pry
  end

end
