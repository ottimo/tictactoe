class Game < ActiveRecord::Base
  validates :table, presence: true, format:  { with: /\A[_XO]{9}\z/,
    message: "only allows 9 sign" }

  def next_player?
    return nil if table.nil?
    res = "X"
    move_counter = 0
    table.each_char do |cell|
      move_counter +=1 if cell == "X"
      move_counter -=1 if cell == "O"
    end
    res = "O" if move_counter > 0

    return res
  end

  def add_sign_to_cell(cell)
    return false if table[cell.to_i] != '_'
    table[cell.to_i] = next_player?
    return true
  end

  def winner
    if compare(table[0],table[1],table[2]) || #winner pattern 012 345 678
       compare(table[3],table[4],table[5]) ||
       compare(table[6],table[7],table[8]) ||
       compare(table[1],table[4],table[7]) || #winner pattern 147 036 258
       compare(table[0],table[3],table[6]) ||
       compare(table[2],table[5],table[8]) ||
       compare(table[0],table[4],table[8]) || #winner pattern 048 246
       compare(table[2],table[6],table[6])
      return "X" if next_player? == "O"
      return "O"
    end

    return nil
  end

  def compare(a,b,c)
    return false if a == "_" || b == "_" || c=="_"
    ba=false
    ca=false
    bc=false
    if b == a
      ba = true
      if b == c
        bc = true
        ca = true
      end
    elsif c == a
      ca = true
    elsif c == b
      bc = true
    end
    return ba && ca && bc
  end
end
