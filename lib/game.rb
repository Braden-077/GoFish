# frozen_string_literal: true 

require_relative 'deck'

class Game
  attr_accessor :deck, :players, :started, :round, :books
  STARTING_HAND = 7
  def initialize(players = [], deck = Deck.new)
    @deck = deck   
    @players = players
    @started = false
    @round = 1
    @books = 0
    deck.shuffle!
  end

  def start
    STARTING_HAND.times {players.each {|player| player.take(deck.deal)}}
    @started = true 
  end

  def play_round(rank, asking_player, player_asked)
    if asking_player.has_card?(rank) && player_asked.has_card?(rank)
      asking_player.take(player_asked.give(rank))
    elsif !player_asked.has_card?(rank)
      "#{player_asked} doesn't have any #{rank}'s. Go Fish."
      go_fish(asking_player)
      up_round
    end
  end

  def turn_player
    if started == true && @round >= 1
      turn = (@round - 1) % players.count 
      players[turn]
    end
  end

  def go_fish(player)
    if deck.cards_left == 0
      'The deck is empty.'
    else
      player.take(deck.deal)
    end
  end

  def up_round
    @round += 1
  end

  def over?
    false
  end
end