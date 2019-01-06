require './lib/enigma'
require './lib/encryption'
require './lib/key'
require './lib/date'
require './lib/crack'
require 'pry'

files = ARGV
message_name = files.first
encryption_name = files.last

message = File.open(message_name, "r").read
enigma = Enigma.new.encrypt(message)

encryption = File.new(encryption_name, "w+")
encryption.puts(enigma[:encryption])
encryption.close

puts "Created #{encryption_name} with the key #{enigma[:key]} and date #{enigma[:date]}"
