require './lib/shifts'
require './lib/crack'
require './lib/enigma'
require './lib/encryption'
require './lib/decryption'

p "Create Enigma?"
name = gets.chomp
p name = Enigma.new
p "Set up enigma"
date = gets.chomp
p name.set_up_enigma(date)
p "Crack package message:"
message = gets.chomp
p "Crack package date"
date = gets.chomp
p "Cracked package:"
p name.crack_package(message, date)
