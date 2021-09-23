module KanaConverter
  require 'nkf'

  def to_hiragana(str)
    NKF.nkf('-h1 -w', str)
  end

  def to_katakana(str)
    NKF.nkf('-h2 -w', str)
  end
end
