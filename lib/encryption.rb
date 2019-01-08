module Encryption

  def encrypt_package(message)
    { :encryption => encode_message(message),
      :key => @key_string,
      :date => @date_string }
  end

  def encode_message(message)
    message.downcase.split("").map.with_index do |char, index|
      find_encode_char(char, index)
    end.join
  end

  def find_encode_char(char, index)
    if @alphabet.include?(char)
      @alphabet[(@alphabet.find_index(char) + @shift[index % 4]) % 27]
    else
      char
    end
  end

end
