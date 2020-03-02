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

  def my_all?(word=nil)
   
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
        false
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

  def my_any?(word=nil)
   
    unless block_given?
      
      if self.size == 0
        false
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
          if j > 0 and j <= self.length
            true
          else
            false
          end
        elsif word != nil
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
          
          if j > 0 and j <= self.length
            true
          else
            false
          end
      else
        true
      end
    else
      i = 0
      j = 0
      while i < self.size
          yield self[i]
          i += 1
      end
      
      for element in self
        if yield element
          j += 1
        end
      end
      if j > 0 and j <= self.size
       true
      else
        false
      end
    end
  end

end

#1) my_select

# p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

# array = ["Theo","Gloria","Veronica"]

#2) my_each

# p array.my_each

#3) my_each_with_index

# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index|
#   hash[item] = index
# }
#p hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
#p array.my_each_with_index
#p array.each_with_index

#4) my_all?

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p [].my_all? #=> true
# p %w[ant bear cat].my_all?(/t/)                        #=> false
#p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false

#5) my_any?

p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false
