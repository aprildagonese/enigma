module Shifts

  def calculate_shift(key, date_string)
    dates = date_offsets(date_string)
    
    key_shifts(key).map do |key, value|
      value.to_i + dates[key].to_i
    end
  end

  def key_shifts(key)
    key_shifts = {  :A => key[0] + key[1],
                    :B => key[1] + key[2],
                    :C => key[2] + key[3],
                    :D => key[3] + key[4] }
  end

  def set_key(key = nil)
    if key == nil
      generate_random_key
    else
      key
    end
  end

  def generate_random_key
    random_key = ""
    5.times do
      random_key += rand(0..9).to_s
    end
    random_key.rjust(5, "0")
  end

  def date_offsets(date_string)
    rounded_date = (date_string.to_i ** 2).to_s
    date_offsets = {  :A => rounded_date[-4],
                      :B => rounded_date[-3],
                      :C => rounded_date[-2],
                      :D => rounded_date[-1] }
  end

  def set_date(date = nil)
    if date == nil
      generate_todays_date
    else
      date
    end
  end

  def generate_todays_date
    date = Time.now.to_s[2..9].gsub(/[-]/, '')
    date[4]+date[5]+date[2]+date[3]+date[0]+date[1]
  end

end
