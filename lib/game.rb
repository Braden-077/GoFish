# frozen_string_literal: true 

class Game
  attr_accessor :deck, :players
  def initialize(deck = Deck.new, players = [])
    @deck = deck   
    @players = players
  end
end