class Replacer
  attr_accessor :range, :iterations

  def initialize range
    @range = range
    @iterations = []
  end

  def replace_multiples(number, value)
    iterations << @range.map do |x|
      x % number == 0 ? value : nil
    end
  end

  def result
    return [] if @iterations.empty?
    array = @range.clone
    iterations.each do |iteration|
      replace_different_values(array, iteration)
    end

    array
  end

  def replace_different_values array, replacement
    array.each_with_index do |value, index|
      array[index] = replacement[index] unless replacement[index].nil?
    end
  end


end