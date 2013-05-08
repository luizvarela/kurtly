require 'digest/sha1'

class TokenGenerator
  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
  MAX_DIGITS = 5
  
  def generate_token(url)
    bas62_encode(hash(url))
  end
  
  private
  
  def bas62_encode(i)
    return ALPHABET[0] if i == 0
    
    s = ''
    base = ALPHABET.length
    until i == 0
      s << ALPHABET[i % base]
      i /= base
    end
    s.reverse
  end
  
  def hash(str)
    Digest::SHA1.hexdigest(str).to_i(16) % (ALPHABET.length ** MAX_DIGITS)
  end
  
end