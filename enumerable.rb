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
          arr << self[i]
        end
        i += 1
      end
      arr
    end
  end

  def my_all?(word = nil)
    unless block_given?
      i = 0
      j = 0
      
      while i < self.size
        self[i]
        i += 1
      end
      if self.size == 0
        true
      elsif word.class == Regexp

        for element in self
          if element =~ word
            j += 1
          end
        end
        j == self.length ? true : false

      elsif word == Numeric

        for element in self
          if element.class <= word
            j += 1
          end
        end
        j == self.length ? true : false
      elsif word != nil
        i = 0
        while i < self.size
          if self[i - 1] == self[i]
            j += 1
          end
          i += 1
        end
        k = 0
        for element in self
          if element.class == word
            k += 1
          end
        end

        for element in self
          if element == word
            k += 1
          end
        end
        
        k == self.length ? true : false
      
      else
        for element in self do
          if element == false or element == nil
            j += 1
          end
        end
        j == 0 ? true : false
      end
    else
      i = 0
      j = 0
      while i < self.size
        yield self[i]
        i += 1
      end

      for element in self

        if yield(element) == false or yield(element) == nil
          j += 1
        end
      end
      j == 0 ? true : false

    end
  end

  def my_any?(word = nil)
    unless block_given?
      i = 0
      j = 0
      while i < self.size
        self[i]
        i += 1
      end
      if self.size == 0
        false
      elsif word.class == Regexp

        for element in self
          if element =~ word
            j += 1
          end
        end
        j > 0 and j <= self.length ? true : false

      elsif word != nil
        i = 0
        k = 0
        while i < self.size
          if word == self[i]
            k += 1
          end
          i += 1
        end
  

        for element in self
          if element.class == word
            k += 1
          end
        end
        k > 0 ? true : false

      elsif word == Numeric
        for element in self
          if element.class <= word
            j += 1
          end
        end
        
        j > 0 and j <= self.length ? true : false

      else
        k = 0
        for element in self do
          if element == false or element == nil
            k += 1
          end
        end
        k != self.size ? true : false

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
      j > 0 and j <= self.size ? true : false
    end
  end

  def my_none?(word = nil)
    unless block_given?
      i = 0
      j = 0
      while i < self.size
        self[i]
        i += 1
      end
      if self.size == 0
        true
      elsif word.class == Regexp

        self.my_each do |element|
          if element =~ word
            j += 1
          end
        end
       
        j == 0 ? true : false

      elsif word != nil
        if word == Numeric
          for element in self
            if element.class <= word
              j += 1
            end
          end
          
          
          j > 0 ? false : true
        else
          i = 0
          k = 0
          for element in self
            if element == word
              k += 1
            end
          end
          while i < self.size
            if self[i].class == word
              k += 1
            end
            i += 1
          end
          k == 0 ? true : false
          
      end

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

  def my_count(val = nil)
    unless block_given?

      if val.class != NilClass
        i = 0

        for el in self do
          if el == val
            i += 1
          end
        end
        i
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

  def my_map(proc_argument = nil)
    unless block_given?
      if proc_argument != nil
       arr = []
      for element in self do
        current = proc_argument.call(element)
        arr << current
      end
      arr
    else
      to_enum(__method__)
    end
    else
      arr = []
      for element in self do
        current = yield element
        arr << current
      end
      arr
    end
  end

   def my_inject(*param)
    
    arr = []
    i = 0
    for element in self do
      arr << element
    end

    unless block_given?

      if param.length == 1
        acc = param[0]
        result = arr[0]
        arr[1..-1].my_each do |el|
          result = result.send(acc, el)
        end
      end
      if param.length == 2
        result = param[0]
        acc = param[1]
        arr.my_each do |el|
          result = result.send(acc, el)
        end
      end
    else
      acc = param[0]
      result = yield(arr[0], arr[1])

      arr.my_each do |e|
        if e.class == String
          result = yield(result, e)
        end

        if i > 1
          result = yield(result, e)
        end
        i += 1
      end
      
      if acc.class <= Numeric
         result = result * acc
       end

  end
    result
  end

  def multiply_els(num = 1)
    self.my_inject(num) { |product, n| product * n }
  end

end
