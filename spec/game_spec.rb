# frozen_string_literal: true 

require 'game'

describe Game do
  describe '#initialize' do
    it 'initializes without error' do
      game = Game.new
      expect{ game }.not_to raise_error
    end
  end

  describe '#play_round' do
    it 'asking player gets cards if asked player has them' do
      asked_player = Player.new('Braden', [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')])
      asking_player = Player.new('Josh', [Card.new('A', 'H')]) 
      game = Game.new([asking_player, asked_player])
      
      game.play_round('A', asking_player, asked_player)

      expect(asked_player.hand).to eq []
      expect(asking_player.hand).to eq [Card.new('A', 'H'), Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')]
    end

    it 'makes a player go fish if the opponent does not have the specified card' do
      asked_player = Player.new('Braden', [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')])
      asking_player = Player.new('Josh', [Card.new('A', 'H')]) 
      game = Game.new([asking_player, asked_player])
      
      game.play_round('Q', asking_player, asked_player)

      expect(asking_player.hand.count).to eq 2
      expect(asked_player.hand).to eq [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')]
    end
  end

  describe '#go_fish' do
    it 'allows the player to go fish and take a card from the deck' do
      player1 = Player.new('Braden')
      player2 = Player.new('Josh')
      game = Game.new([player1, player2])
      game.go_fish(player1)
      expect(player1.card_count).to eq 1
    end

    it 'does not allow the player to take from an empty deck' do
      player1 = Player.new('Braden')
      player2 = Player.new('Josh')
      game = Game.new([player1, player2], Deck.new([]))
      expect(game.go_fish(player1)).to eq 'The deck is empty.'
      expect(player1.card_count).to eq 0
    end
  end

  describe '#start' do
    it 'deals 7 cards to the player when start is called' do
      game = Game.new([Player.new('Braden'), Player.new('Josh')])
      game.start
      expect(game.players.first.card_count).to eq 7
      expect(game.players.last.card_count).to eq 7
    end
  end

  describe '#turn_player' do
    it 'returns nil when game has not been started' do
      game = Game.new([Player.new('Josh'), Player.new('Braden')])
      expect(game.turn_player).to be_nil
    end

    it 'returns the first player when no turns have been taken' do
      game = Game.new([Player.new('Josh'), Player.new('Braden')])
      game.start
      expect(game.turn_player.name).to eq 'Josh'
    end

    it 'returns the second player when one turn has been taken' do
      asked_player = Player.new('Braden', [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')])
      asking_player = Player.new('Josh', [Card.new('A', 'H')]) 
      game = Game.new([asking_player, asked_player])
      
      game.started = true  
      expect(game.started).to be true
      expect(game.turn_player.name).to eq 'Josh'
      game.play_round('Q', asking_player, asked_player)
      expect(game.round).to eq 2
      expect(game.turn_player.name).to eq 'Braden'
      game.play_round('Q', asking_player, asked_player)
      expect(game.turn_player.name).to eq 'Josh'
    end

  end
end