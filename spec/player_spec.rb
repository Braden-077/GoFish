# frozen_string_literal: true 

require 'player'

describe Player do
  describe '#initialize' do
    it 'gives default values for all of a players attributes' do
      player = Player.new
      expect(player.name).to eq ''
      expect(player.hand).to eq []
      expect(player.books).to eq []
    end

    it 'allows a player to give values for their name and hand' do
      player = Player.new('Braden', [Card.new('A', 'S')])
      expect(player.name).to eq 'Braden'
      expect(player.hand.length).to eq 1
      expect(player.hand.pop).to eq Card.new('A', 'S')
    end
  end

  describe '#take' do
    it 'allows the player to take a card into their hand' do
      player = Player.new
      card = Card.new('A', 'S')
      expect(player.hand.length).to eq 0
      player.take(card)
      expect(player.hand.length).to eq 1
      expect(player.hand.first).to eq Card.new('A', 'S')
    end

    it 'allows the player to take multiple cards into their hand' do
      player = Player.new
      cards = [Card.new('A', 'S'), Card.new('2', 'C'), Card.new('3', 'D'), Card.new('4', 'H')]
      player.take(cards)
      expect(player.hand.length).to eq 4
      expect(player.hand).to eq cards
    end
  end
  # TODO (after skeleton works): Write test to check for books and sort the hand for book
end