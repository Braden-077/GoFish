# frozen_string_literal: true 

require_relative 'deck'

class Game
  attr_accessor :deck, :players, :started, :round, :round_output
  STARTING_HAND = 7
  def initialize(players = [], deck = Deck.new, started = false)
    @deck = deck
    @round_output = round_output
    @players = players
    @started = started
    @round = 1
    deck.shuffle!
  end

  def start
    STARTING_HAND.times {players.each {|player| player.take(deck.deal)}}
    @started = true 
  end

  def play_round(rank, asking_player, player_asked)
    if asking_player.has_card?(rank) && player_asked.has_card?(rank)
      outcome_one(rank, asking_player, player_asked)
    elsif !player_asked.has_card?(rank)
      outcome_two(rank, asking_player, player_asked)
      up_round
    end
  end

  def turn_player
    if started == true
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

  def get_player(name)
    players.find {|player| player.name == name}
  end

  private 
  
  def outcome_one(rank, asking_player, player_asked)
    @round_output = "#{player_asked.name} had #{rank}. #{asking_player.name} go again!"
    asking_player.take(player_asked.give(rank))
  end

  def outcome_two(rank, asking_player, player_asked)
    @round_output = "#{player_asked.name} doesn't have any #{rank}'s. Go Fish."
    go_fish(asking_player)
  end
end