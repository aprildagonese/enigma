module Decryption

  def decrypt_package(message, key, date)
    @ciphertext = message
    set_up_enigma(key, date)
    @decrypted = { :decryption => generate_decryption(message),
                   :key => @key_object.key_string,
                   :date => @dateid_object.date_string }
  end

  def generate_decryption(message)
    calculate_shift
    decode_ciphertext(message)
  end


  def decode_ciphertext(message)
    new_chars = []
    message.downcase.split("").each do |char|
      if @alphabet.include?(char)
        difference = @alphabet.find_index(char) - (@shift[0] % 27)
        if difference >= 0
          new_index = difference
        else
          new_index = 27 - difference.abs
        end
        new_chars << @alphabet[new_index]
      else
        new_chars << char
      end
      @shift = @shift.rotate
    end
    new_chars.join
  end

end
