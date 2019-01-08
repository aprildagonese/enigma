module Decryption

  def decrypt_package(message, key, date)
    { :decryption => decode_ciphertext(message, @shift),
      :key => @key_string,
      :date => @date_string }
  end

  def decode_ciphertext(message, shift)
    message.downcase.split("").map.with_index do |char, index|
      find_decode_char(char, index, shift)
    end.join
  end

  def find_decode_char(char, index, shift)
    if @alphabet.include?(char)
      @alphabet[@alphabet.find_index(char) - (shift[index % 4] % 27)]
    else
      char
    end
  end

end
