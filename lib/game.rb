# frozen_string_literal: true 

class Game
  attr_accessor :deck, :players
  def initialize(players = [], deck = Deck.new)
    @deck = deck   
    @players = players
  end

  def ask_for_card(rank, asking_player, player_asked)
    # player1 checks hand to see if they have the specified rank
    # player1 takes any cards matching the specified rank from player 2's hand
    if asking_player.has_card?(rank) && player_asked.has_card?(rank)
      asking_player.take(player_asked.give(rank))
    end
  end
end