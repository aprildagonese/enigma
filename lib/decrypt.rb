require './lib/enigma'

args = ARGV
ciphertext_file = args[0]
message_name = args[1]
key = args[2]
date = args[3]

ciphertext = File.open(ciphertext_file, "r").read
enigma = Enigma.new.decrypt(ciphertext, key, date)

decoded_message = File.new(message_name, "w+")
decoded_message.puts(enigma[:decryption])
decoded_message.close

puts "Created #{message_name} with the key #{enigma[:key]} and date #{enigma[:date]}"
