class Game < ActiveRecord::Base
  validates :table, presence: true, format:  { with: /\A[012]{9}\z/,
    message: "only allows 9 number" }

  def next_player?
    return nil if table.nil?
    res = "X"
    move_counter = 0
    table.each_char do |cell|
      move_counter +=1 if cell == "1"
      move_counter -=1 if cell == "2"
    end
    res = "O" if move_counter > 0

    return res
  end

  def add_sign_to_cell(cell)
    return false if table[cell.to_i].to_i != 0
    sign = 1
    sign = 2 if next_player? == "O"
    table[cell.to_i] = sign.to_s
    return true
  end

  def winner
    #winner pattern 012 345 678
    if compare(table[0],table[1],table[2])
      return "X" if next_player? == "O"
      return "O"
    end
    if compare(table[3],table[4],table[5])
      return "X" if next_player? == "O"
      return "O"
    end
    if compare(table[6],table[7],table[8])
      return "X" if next_player? == "O"
      return "O"
    end

    #winner pattern 147 036 258


    if compare(table[1],table[4],table[7])
      return "X" if next_player? == "O"
      return "O"
    end
    if compare(table[0],table[3],table[6])
      return "X" if next_player? == "O"
      return "O"
    end
    if compare(table[2],table[5],table[8])
      return "X" if next_player? == "O"
      return "O"
    end


    #winner pattern 048 246

    if compare(table[0],table[4],table[8])
      return "X" if next_player? == "O"
      return "O"
    end
    if compare(table[2],table[6],table[6])
      return "X" if next_player? == "O"
      return "O"
    end

    return nil
  end

  def compare(a,b,c)
    return false if a == "0" || b == "0" || c=="0"
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
