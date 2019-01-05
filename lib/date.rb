require './lib/key'
require './lib/enigma'
require 'date'

class DateID
  attr_reader :date_string

  def initialize(date = nil)
    if date == nil
      @date_string = generate_todays_date
    else
      @date_string = date.to_s
    end
  end

  def generate_todays_date
    date = Time.now.to_s[2..9].gsub(/[-]/, '')
    date = date[4]+date[5]+date[2]+date[3]+date[0]+date[1]
  end

  def date_offsets
    rounded_date = (@date_string.to_i ** 2).to_s
    date_offsets = {  :A => rounded_date[-4],
                      :B => rounded_date[-3],
                      :C => rounded_date[-2],
                      :D => rounded_date[-1] }
  end

end
