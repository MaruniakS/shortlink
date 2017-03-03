module Shuffle
  def pseudo_random(str)
    n = 7
    while n > 0 do
      str = shuffle(str.scan(/.{1,#{n}}/))
      n -= 1
    end
    str
  end

  def shuffle(arr)
    arr.partition.each_with_index{ |_, i| i.odd? }.join('')
  end
end
