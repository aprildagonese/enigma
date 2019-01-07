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


  end

end
