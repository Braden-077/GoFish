# frozen_string_literal: true 

require_relative 'deck'

class Game
  attr_accessor :deck, :players, :started, :round, :round_output, :fish
  STARTING_HAND = 7
  def initialize(players = [], deck = Deck.new, started = false)
    @deck = deck
    @round_output = round_output
    @players = players
    @started = started
    @round = 1
  end

  def start
    STARTING_HAND.times {players.each {|player| player.take(deck.deal)}}
    @started = true 
  end

  def play_round(rank, player_asked)
    if turn_player.has_card?(rank) && player_asked.has_card?(rank)
      outcome_one(rank, player_asked)
    elsif !player_asked.has_card?(rank)
      outcome_two(rank, player_asked)
    elsif !turn_player.has_card?(rank)
      outcome_three(rank, turn_player)
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
      up_round
      'The deck is empty.'
    else
      @fish = player.take(deck.deal).first.rank
    end
  end

  def up_round
    @round += 1
  end

  def over?
    players.sum {|player| player.books.length} == 13
  end

  def get_player(name)
    players.find {|player| player.name == name}
  end

  private 
  
  def outcome_one(rank, player_asked)
    @round_output = "#{player_asked.name} had #{rank}'s. #{turn_player.name} go again!"
    turn_player.take(player_asked.give(rank))
    turn_player.check_for_book(rank)
  end

  def outcome_two(rank, player_asked)
    @round_output = "#{player_asked.name} doesn't have any #{rank}'s. Go Fish."
    go_fish(turn_player)
    if @fish == rank
      turn_player.check_for_book(rank)
    else
      turn_player.check_for_book(@fish)
    up_round
    end
  end

  def outcome_three(rank, turn_player)
    @round_output = "Silly #{turn_player.name}, you can't ask for #{rank}! You don't have any. Try again!"
  end
end