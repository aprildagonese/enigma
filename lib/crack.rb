require './lib/enigma'

args = ARGV
ciphertext_file = args[0]
message_name = args[1]
date = args[2]

ciphertext = File.open(ciphertext_file, "r").read

enigma = Enigma.new
cracked_message = enigma.crack(ciphertext.chomp, date)

decoded_message = File.new(message_name, "w+")
decoded_message.puts(cracked_message[:decryption])
decoded_message.close

puts "Created #{message_name} with the key #{cracked_message[:key]} and date #{cracked_message[:date]}"
