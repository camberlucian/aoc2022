def rps(data)
    score = 0
    rules = {"X" => {"beats" => "C", "equals" => "A", "value" => 1},
            "Y" => {"beats" => "A", "equals" => "B", "value" => 2},
            "Z" => {"beats" => "B", "equals" => "C", "value" => 3}}
  
    data.each do |line|
      inputs = line.split(" ")
      elf = inputs[0]
      player = inputs[1]
      if rules[player]["equals"] == elf
        score += (3 + rules[player]["value"])
      elsif rules[player]["beats"] == elf
        score += (6 + rules[player]["value"])
      else
        score += rules[player]["value"]
      end
    end
    score
  end

  def rps2(data)
    score = 0
    rules = {"A" => {"X" => 3, "Y" => 4, "Z" => 8},
            "B" => {"X" => 1, "Y" => 5, "Z" => 9},
            "C" => {"X" => 2, "Y" => 6, "Z" => 7}}
  
    data.each do |line|
      inputs = line.split(" ")
      elf = inputs[0]
      player = inputs[1]
      score += rules[elf][player]
    end
    score
  end