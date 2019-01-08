require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/shifts'
require './lib/encryption'
require './lib/decryption'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @enigma2 = Enigma.new
    @enigma3 = Enigma.new
    @enigma4 = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_sets_key
    assert_equal "11111", @enigma.set_key("11111")
    assert_equal 5, @enigma.set_key.length
    assert_equal String, @enigma.set_key.class
  end

  def test_it_generates_random_5_digit_key
    key_a = @enigma.generate_random_key
    key_b = @enigma.generate_random_key

    assert_equal String, key_a.class
    assert_equal 5, key_a.length
    assert_equal 5, key_b.length
  end

  def test_it_stores_given_key_in_set_up_shift
    @enigma.set_up_shift("01234")
    assert_equal "01234", @enigma.key_string
  end

  def test_it_stores_random_key_in_set_up_shift
    @enigma.set_up_shift
    assert_equal 5, @enigma.key_string.length
    assert_equal String, @enigma.key_string.class
  end

  def test_it_splits_key_into_key_shifts
    expected = { :A => "01",
                 :B => "12",
                 :C => "23",
                 :D => "34" }

    assert_equal expected, @enigma.key_shifts("01234")
  end

  def test_it_generates_todays_date
    assert_equal "080119", @enigma.generate_todays_date
  end

  def test_it_sets_date
    assert_equal "080119", @enigma.set_date
    assert_equal "101183", @enigma.set_date("101183")
  end

  def test_it_sets_up_enigma_no_date_given
    @enigma.set_up_enigma("011118")

    assert_equal "011118", @enigma.date_string
  end

  def test_it_sets_up_enigma_no_date_given
    @enigma.set_up_enigma

    assert_equal String, @enigma.date_string.class
    assert_equal 6, @enigma.date_string.length
  end

  def test_it_splits_date_into_offsets
    expected = { :A => "9",
                 :B => "9",
                 :C => "2",
                 :D => "4" }
    assert_equal expected, @enigma.date_offsets("111118")

    expected2 = { :A => "9",
                  :B => "4",
                  :C => "8",
                  :D => "9" }
    assert_equal expected2, @enigma.date_offsets("101183")
  end

  def test_it_calculates_shift

    assert_equal [10, 16, 31, 43], @enigma.calculate_shift("01234", "101183")
    assert_equal [98, 2, 5, 42], @enigma.calculate_shift("90037", "130385")
  end

  def test_it_finds_encode_chars
    @enigma.set_up_enigma("080119")
    @enigma.set_up_shift("11111")

    assert_equal "m", @enigma.find_encode_char("a", 5)
    assert_equal "!", @enigma.find_encode_char("!", 10)
  end

  def test_it_encodes_message
    encryption = @enigma.encrypt("ABCD", "01234", "101183")

    assert_equal "krgt", encryption[:encryption]
  end

  def test_it_encrypts_package
    @enigma.set_up_enigma("101183")
    @enigma.set_up_shift("11111")

    expected =  { :encryption => "aphibbxll",
                  :key => "11111",
                  :date => "101183" }

    assert_equal expected, @enigma.encrypt_package("happiness")
  end

  def test_encryption_key_and_date_given
    expected =  { :encryption => "lspiuftg",
                  :key => "88888",
                  :date => "101183" }
    expected2 =  { :encryption => "lspiuftg!",
                   :key => "88888",
                   :date => "101183" }
    assert_equal expected, @enigma.encrypt("whatever", "88888", "101183")
    assert_equal expected2, @enigma2.encrypt("whatever!", "88888", "101183")
  end

  def test_encryption_no_key_or_date_given
    encryption1 = @enigma.encrypt("whatever")
    encryption2 = @enigma2.encrypt("whatever")

    assert_equal 5, encryption1[:key].length
    assert_equal "080119", encryption1[:date]
    assert_equal 5, encryption2[:key].length
    assert_equal "080119", encryption2[:date]
    assert_equal false, encryption1[:key] == encryption2[:key]
  end

  def test_encryption_current_date_stored
    encoded1 = @enigma.encrypt("whatever", "12345")
    encoded2 = @enigma.encrypt("whatever", "67890")

    assert_equal "080119", encoded1[:date]
    assert_equal "080119", encoded2[:date]
  end

  def test_decryption_key_and_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, @enigma.decrypt("lspiuftg", "88888", "101183")
  end

  def test_decryption_key_and_date_given_special_chars
    expected =  { :decryption => "tests!",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, @enigma.decrypt("ipgih!", "88888", "101183")
  end

  def test_decryption_no_date_given
    expected =  { :decryption => "whatever",
                  :key => "88888",
                  :date => "080119" }
    assert_equal expected, @enigma.decrypt("gpnapcrz", "88888")
  end

  def test_it_finds_decode_chars
    @enigma.set_up_enigma("080119")
    @enigma.set_up_shift("11111")
    shift = [15, 12, 17, 12]

    assert_equal "a", @enigma.find_decode_char("m", 5, shift)
    assert_equal "!", @enigma.find_decode_char("!", 10, shift)
  end

  def test_it_decodes_cyphertext
    decryption1 = @enigma.decrypt("krgt", "01234", "101183")
    decryption2 = @enigma.decrypt("lspiuftg", "88888", "101183")
    decryption3 = @enigma.decrypt("@cgx0wt!", "88888", "101183")

    assert_equal "abcd", decryption1[:decryption]
    assert_equal "whatever", decryption2[:decryption]
    assert_equal "@ssh0le!", decryption3[:decryption]
  end

  def test_it_decrypts_package
    @enigma.set_up_enigma("101183")
    @enigma.set_up_shift("11111")

    expected =  { :decryption => "happiness",
                  :key => "11111",
                  :date => "101183" }

    assert_equal expected, @enigma.decrypt_package("aphibbxll", "11111", "101183")
  end

  def test_it_cracks_keys
    @enigma.set_up_enigma("080119")
    assert_equal "49841", @enigma.crack_key("zwws", "080119")

    @enigma.set_up_enigma("101183")
    assert_equal "12345", @enigma.crack_key("uebd", "101183")

    @enigma2.set_up_enigma("111118")
    assert_equal "12345", @enigma2.crack_key("ujwz", "111118")
  end

  def test_it_cracks_package
    @enigma.set_up_enigma("101183")
    expected =  { :decryption => "whatever end",
                  :key => "88888",
                  :date => "101183" }
    assert_equal expected, @enigma.crack_package("lspiuftgppbt", "101183")

    @enigma3.set_up_enigma("111118")
    expected3 =  { :decryption => "abcdefghijkl end",
                  :key => "12345",
                  :date => "111118" }
    assert_equal expected3, @enigma3.crack_package("vglzzkpccotgujwz", "111118")

    @enigma4.set_up_enigma("111118")
    expected4 =  { :decryption => "hiapril! end",
                  :key => "12345",
                  :date => "111118" }
    assert_equal expected4, @enigma4.crack_package("bnjklnu!ujwz", "111118")
  end

  def test_it_cracks_package_special_chars
    @enigma2.set_up_enigma("111118")
    expected2 =  { :decryption => "whatever! end",
                   :key => "12345",
                   :date => "111118" }
    assert_equal expected2, @enigma2.crack_package("qmjoz nm!eniy", "111118")
  end

  def test_it_cracks
    expected =  { :decryption => "inspiration end",
                  :key => "98765",
                  :date => "260454" }
    assert_equal expected, @enigma.crack("euofeyxjevjqau ", "260454")

    expected2 =  { :decryption => "compassion end",
                  :key => "11111",
                  :date => "051257" }
    assert_equal expected2, @enigma2.crack("nzailcgbzyoyyo", "051257")

    expected3 =  { :decryption => "kindness end",
                  :key => "55473",
                  :date => "101183" }
    assert_equal expected3, @enigma3.crack("umoexittjioe", "101183")
  end

  def test_it_cracks_special_chars
    expected =  { :decryption => "laughter! end",
                  :key => "01030",
                  :date => "130385" }
    assert_equal expected, @enigma.crack("umzoqejz!ljvm", "130385")

    expected =  { :decryption => "*magic* end",
                  :key => "28282",
                  :date => "300983" }
    assert_equal expected, @enigma.crack("*pjqpf*jlqm", "300983")
  end

end
