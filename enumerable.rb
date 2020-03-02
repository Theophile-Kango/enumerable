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

  def my_select
    unless block_given?
      to_enum(__method__)
    else
      i = 0
      arr = []
      while i < self.size
        yield self[i]
        if yield self[i]
          arr.push(self[i])
        end
        i += 1
      end
      arr
    end
  end

  def my_all(word=nil)
   
    unless block_given?
      
      if self.size == 0
        true
      elsif word.class == Regexp
          i = 0
          j = 0
          while i < self.size
              self[i]
              i += 1
          end
          for element in self
            if element.match(word)
              j += 1
            end
          end
          if j == self.length
            true
          else
            false
          end
        elsif word == Numeric
          i = 0
          j = 0
          while i < self.size
              self[i]
              i += 1
          end
          for element in self
            if element.class <= word
              j += 1
            end
          end
          
          if j == self.length
            true
          else
            false
          end
      else
        to_enum(__method__)
      end
    else
      i = 0
      while i < self.size
          yield self[i]
          i += 1
      end
      
     
      if yield self
        true
      else
        false
      end

    end
  end
end


p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

array = ["Theo","Gloria","Veronica"]

print array.my_each

hash = Hash.new
%w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
}
#p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
#p array.my_each_with_index
#p array.each_with_index

p %w[ant bear cat].my_all { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all { |word| word.length >= 4 } #=> false
p [].my_all #=> true
p %w[ant bear cat].my_all(/t/)                        #=> false
p [1, 2i, 3.14].my_all(Numeric)                       #=> true
