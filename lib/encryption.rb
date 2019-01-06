require './lib/enigma'

class Encryption < Enigma

  def encrypt(message, key = nil, date = nil)
    set_up_enigma(key, date)
    self.calculate_shift
    @encrypted = { :encryption => encode_message(message),
                  :key => @key_object.key_string,
                  :date => @dateid_object.date_string }
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
