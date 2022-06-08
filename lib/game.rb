# frozen_string_literal: true 

class Game
  attr_accessor :deck, :players
  def initialize(players = [], deck = Deck.new)
    @deck = deck   
    @players = players
  end
end