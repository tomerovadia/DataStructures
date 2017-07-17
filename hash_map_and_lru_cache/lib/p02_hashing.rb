require 'byebug'

class Fixnum
  # done!
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, idx|
      sum += (el.hash + idx).hash
    end

    sum.hash
  end
end

class String
  def hash
    self.chars.map{|char| char.ord}.hash + 1
  end
end

class Hash
  def hash
    self.to_a.flatten.map{|el| el.to_s.ord}.sort.hash
  end
end
