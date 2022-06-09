# frozen_string_literal: true 

require 'game'

describe Game do
  describe '#initialize' do
    it 'initializes without error' do
      game = Game.new
      expect{ game }.not_to raise_error
    end
  end

  describe '#ask_for_card' do
    it 'asking player gets cards if asked player has them' do
      asked_player = Player.new('Braden', [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')])
      asking_player = Player.new('Josh', [Card.new('A', 'H')]) 
      game = Game.new([asking_player, asked_player])
      
      game.ask_for_card('A', asking_player, asked_player)

      expect(asked_player.hand).to eq []
      expect(asking_player.hand).to eq [Card.new('A', 'H'), Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')]
    end
  end
end