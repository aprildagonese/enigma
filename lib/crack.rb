module Crack

  def crack_package(message)
    split_chars = message.split("")
  end

  def calculate_key_chars(message, date)
    last_four_chars = message.split("")[-4..-1]
    key_string = "00000"
    date_shifts = find_date_rotation(message, date)
    @shift = alternative_shift(key_string, date_shifts)

    until decode_ciphertext(last_four_chars.join) == " end"
      key_string = key_string.next
    end
    key_string
  end

  def find_date_rotation(ciphertext, date = generate_todays_date)
    rotation_count = ciphertext.length % 4
    date_shifts = date_offsets(date).values
    rotation_count.times do
      date_shifts = date_shifts.rotate
    end
    date_shifts
  end

  def alternative_shift(key, date_shifts)
    dates = date_shifts
    key_shifts(key).map do |key, value|
      value.to_i + dates[0].to_i
      dates = dates.rotate
    end
  end

end
