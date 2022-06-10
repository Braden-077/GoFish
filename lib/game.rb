# frozen_string_literal: true 

require_relative 'deck'

class Game
  attr_accessor :deck, :players
  def initialize(players = [], deck = Deck.new)
    @deck = deck   
    @players = players
  end

  def play_round(rank, asking_player, player_asked)
    if asking_player.has_card?(rank) && player_asked.has_card?(rank)
      asking_player.take(player_asked.give(rank))
    elsif !asking_player.has_card?(rank) 
      "You can't ask for a card you don't have."
    elsif !asked_player.has_card?(rank)
      puts "#{player} does not have any #{rank}s. Go fish!" 
      go_fish(asking_player)
    end
  end

  def go_fish(player)
    if deck.cards_left == 0
      'The deck is empty.'
    else
      player.take(deck.deal)
    end
  end
end