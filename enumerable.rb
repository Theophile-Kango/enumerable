# rubocop:disable all
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

  def my_none?(word = nil)
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
          j == 0 ? true : false
            
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
          
          j != 0 ? false : true
        
      else
        j = 0
        self.my_each do |e|
          if e == true
            j += 1
          end
        end
        j == 0 ? true : false
      end
    else
      i = 0
      while i < self.size
          yield self[i]
          i += 1
      end
      j = 0
      self.my_each do |element|
        if yield element
          j += 1
        end
      end
      j == 0 ? true : false
        
    end
    
  end

  def my_count(val=nil)

    unless block_given?
      
      if val.class != NilClass
        i = 0
        self.my_each do |count|
          if self[count] == val
            i += 1
          end
        end
        val
      else
        self.my_each do |count|
          count += 1
        end
        count
      end
    else
      j = 0
      self.my_each do |element|
        if yield element
          j += 1
        end
      end
      j
    end
  end
    
  def my_map
    unless block_given?
      to_enum(__method__)
    else
      arr = []
      for element in self do
        current = yield element
        arr.push(current)
      end
      arr
    end
  end

  def my_inject(acc = nil)
    arr = []
    arr2 = []

    for element in self do
      if element.class == String
        result = yield(element,element)
      else
        result = yield(element, element.next)
      end
      arr.push(result)
    end
    
    i = 0
    j = 0
    while i < arr.length do
      if arr[i].class == String
        arr2.push(arr[i])
      else
      if i.even?
        arr2.push(arr[i])
      end
    end
      i += 1
    end
  
    result = yield(arr2[0], arr2[1])
    
    arr2.my_each do |e|
      if e.class  == String
        result = yield(result, e)
      end
        
      if j > 1
        result = yield(result, e)
      end
      j += 1
    end
    if acc.class <= Numeric
      result = result * acc
    end
    result
  end

  def multiply_els(num=1)
    self.my_inject(num) { |product, n| product * n }
  end

  def my_map_proc(&block)
    my_map
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

# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false

#6) my_none?

# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

#7) my_count
# ary = [1, 2, 4, 2]
# p ary.my_count               #=> 4
# p ary.my_count(2)            #=> 2
# p ary.my_count{ |x| x%2==0 } #=> 3

#8) my_map
# p (1..4).my_map
# p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

#9) my_inject
#p (5..10).my_inject 
# p (5..10).my_inject { |sum, n| sum + n }            #=> 45
# p (5..10).my_inject(1) { |product, n| product * n } #=> 151200

# longest = %w{ cat sheep bear }.my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest

#10) multiply_els

# p (5..10).multiply_els

#11) my_map_proc

p (1..4).my_map_proc{ |i| i*i }  