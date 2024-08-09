class PostCode
  attr_reader :value

  def initialize(value)
    @value = value.to_i
  end

  def valid?
    @value.to_s.chars.any? { |digit| ('1'..'5').include?(digit) }
  end
end
