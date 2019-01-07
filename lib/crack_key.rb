module Crack

  def crack_package(message, date)
    @key_string = crack_key(message, date)
    @shift = calculate_shift(@key_string, date)
    @decrypted = {  :decryption => decode_ciphertext(message, @shift),
                    :key => @key_string,
                    :date => @date_string }
  end

  def crack_key(message, date)
    key_strings = ("00000".."99999").to_a
    correct_key = find_key(key_strings, message, date)
  end

  def find_key(key_strings, message, date)
    key_strings.find do |key|
      shift = calculate_shift(key, date)
      rotated_shift = shift.rotate(message.length % 4)
      decode_ciphertext(message[-4..-1], rotated_shift) == " end"
    end
  end

end
