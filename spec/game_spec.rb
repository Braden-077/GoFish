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
end