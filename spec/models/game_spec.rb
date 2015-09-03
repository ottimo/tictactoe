require 'rails_helper'

RSpec.describe Game, type: :model do
  it{
    game = Game.new
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '________')
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '__________')
    expect(game.valid?).to be false
  }
  it{
    game = Game.new(table: '_________')
    expect(game.valid?).to be true
  }
  describe "select next player" do
    it{
      game = Game.new(table: '_________')
      expect(game.next_player?).to eq "X"
    }
    it{
      game = Game.new(table: '____X____')
      expect(game.next_player?).to eq "O"
    }
    it{
      game = Game.new(table: '__O_X____')
      expect(game.next_player?).to eq "X"
    }
  end

  describe "insert a sign" do
    it{
      game = Game.new(table: '____X____')
      expect(game.add_sign_to_cell(4)).to be false
    }

    it{
      game = Game.new(table: '____X____')
      expect(game.add_sign_to_cell(3)).to be true
      expect(game.table).to eq '___OX____'
    }

    it{
      game = Game.new(table: '___OX____')
      expect(game.add_sign_to_cell(0)).to be true
      expect(game.table).to eq 'X__OX____'
    }
  end

  describe "winner?" do
    it{
      game = Game.new(table: '____X____')
      expect(game.winner).to eq nil
    }
    it{
      game = Game.new(table: 'XXXOXOO__')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: 'OOOXOXX__')
      expect(game.winner).to eq "O"
    }
    it{
      game = Game.new(table: 'X___X___X')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '__X_X_X__')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '______XXX')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '___XXX___')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: 'XXX______')
      expect(game.winner).to eq "X"
    }

    it{
      game = Game.new(table: '__X__X__X')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: '_X__X__X_')
      expect(game.winner).to eq "X"
    }
    it{
      game = Game.new(table: 'X__X__X__')
      expect(game.winner).to eq "X"
    }

  end

  describe "compare" do
    it{
      game = Game.new
      expect(game.compare("X","X","X")).to eq true
    }
    it{
      game = Game.new
      expect(game.compare("O","X","X")).to eq false
    }
    it{
      game = Game.new
      expect(game.compare("O","X","O")).to eq false
    }
    it{
      game = Game.new
      expect(game.compare("_","_","_")).to eq false
    }
  end

end
