require 'rails_helper'

RSpec.describe Game, type: :model do
  it{
    game = Game.new
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '00000000')
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '0000000000')
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '000000000')
    expect(game.valid?).to be true
  }
  describe "select next player" do
    it{
      game = Game.new(table: '000000000')
      expect(game.next_player?).to eq "X"
    }
    it{
      game = Game.new(table: '000010000')
      expect(game.next_player?).to eq "O"
    }
    it{
      game = Game.new(table: '002010000')
      expect(game.next_player?).to eq "X"
    }
  end

  describe "insert a sign" do
    it{
      game = Game.new(table: '000010000')
      expect(game.add_sign_to_cell(4)).to be false
    }

    it{
      game = Game.new(table: '000010000')
      expect(game.add_sign_to_cell(3)).to be true
      expect(game.table).to eq '000210000'
    }

    it{
      game = Game.new(table: '000210000')
      expect(game.add_sign_to_cell(0)).to be true
      expect(game.table).to eq '100210000'
    }
  end

  describe "winner?" do
    it{
      game = Game.new(table: '000010000')
      expect(game.winner).to eq nil
    }
    it{
      game = Game.new(table: '111212200')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '222121100')
      expect(game.winner).to eq "O"
    }
    it{
      game = Game.new(table: '100010001')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '001010100')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '000000111')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '000111000')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '111000000')
      expect(game.winner).to eq "X"
    }

    it{
      game = Game.new(table: '001001001')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '010010010')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '100100100')
      expect(game.winner).to eq "X"
    }

  end

end
