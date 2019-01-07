module Crack

  def crack_package(message, date)
    @key_string = crack_key(message, date)
    @shift = calculate_shift(@key_string, date)
    @decrypted = {  :decryption => decode_ciphertext(message, @shift),
                    :key => @key_string,
                    :date => @date_string }
  end

  def crack_key(message, date)
    last_four_chars = message.split("")[-4..-1]
    key_strings = ("00000".."99999").to_a
    date_shift = date

    correct_key = key_strings.find do |key|
      shift = calculate_shift(key, date_shift)
      shift = shift.rotate(message.length % 4)
      decode_ciphertext(last_four_chars.join, shift) == " end"
    end
    correct_key
  end

end
