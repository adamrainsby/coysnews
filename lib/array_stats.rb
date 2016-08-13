module ArrayStats
  def median array
    raise ArgumentError unless array.class == Array

    sorted = array.sort
    count = sorted.size
    i = count / 2

    return nil if count == 0
    if count % 2 == 1
      sorted[i].to_f
    else
      (sorted[i - 1] + sorted[i]) / 2.0
    end
  end
end
