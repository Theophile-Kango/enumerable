module Enumerable
  def my_each
    unless block_given?
      to_enum(__method__)
    else
      i = 0
      while i < self.size
        yield self[i]
        i += 1
      end
      self
    end
  end

  def my_each_with_index
    unless block_given?
      to_enum(__method__)
    else
      i = 0
      while i < self.size
        yield(self[i], i)
        i += 1
      end
      self
    end
  end
end


array = ["Theo","Gloria","Veronica"]

print array.my_each

hash = Hash.new
%w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
}
p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
p array.my_each_with_index
p array.each_with_index
