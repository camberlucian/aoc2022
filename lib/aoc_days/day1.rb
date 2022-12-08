def unit_totals(data)
    unit_total = 0
    totals = []
    data.each_with_index do |n, index|
      case n.to_i
      when 0
        totals << unit_total
        unit_total = 0
      else
        unit_total += n.to_i
        if index == data.size - 1
          totals << unit_total
        end
      end
    end
    totals
  end

def top_total(data, range)
    i = 0
    total = 0
    while i < range do
        number = data.max
        total += number
        data.delete_at(data.index(number))
        i += 1
    end
    total
end