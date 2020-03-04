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
      k = 0
      while i < self.size
        self[i]
        i += 1
      end
      if self.size == 0
        true
      elsif word.class == Regexp

        for element in self
          if element.match(word)
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
            k += 1
          end
          i += 1
        end

        for element in self
          if element.class == word
            j += 1
          end
        end
        j == self.length ? true : false
        k == self.length ? true : false

      else
        for element in self do
          if element == false or element == nil
            k += 1
          end
        end
        k == 0 ? true : false
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
          if element.match(word)
            j += 1
          end
        end
        j > 0 and j <= self.length ? true : false

      elsif word != nil
        i = 0
        k = 0
        while i < self.size
          if self[i - 1] == self[i]
            k += 1
          end
          i += 1
        end

        for element in self
          if element == word
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

        for element in self
          if element.match(word)
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

          j != 0 ? false : true
        else
          i = 0
          k = 0
          while i < self.size
            if self[i] == word
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

  def my_map
    unless block_given?
      to_enum(__method__)
    else
      arr = []
      for element in self do
        current = yield element
        arr << current
      end
      arr
    end
  end

  def my_inject(acc = nil)
    arr = []
    i = 0
    for element in self do
      arr << element
    end

    unless block_given?

      if acc.class == Symbol
        case acc
        when :+
          result = 0
        when :-
          result = 0
        else
          result = 1
        end
        for el in arr do
          result = result.send(acc, el)
        end
      end
    else

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

  def my_map_proc(&block)
    my_map
  end
end
