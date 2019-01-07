module Encryption

  def encrypt_package(message)
    encrypted = { :encryption => encode_message(message),
                  :key => @key_string,
                  :date => @date_string }
  end

  def encode_message(message)
    new_chars = []
    message.downcase.split("").each do |char|
      if @alphabet.include?(char)
        new_index = (@alphabet.find_index(char) + @shift[0]) % 27
        new_chars << @alphabet[new_index]
      else
        new_chars << char
      end
      @shift = @shift.rotate
    end
    new_chars.join
  end

end
