# frozen_string_literal: true 

require_relative 'game'
require_relative 'player'
require 'pry'

class GameManager
  attr_accessor :clients, :player_names, :game, :associated_list
  def initialize(clients = [], player_names = [])
    @clients = clients
    @player_names = create_players(player_names)
    @game = Game.new(@player_names)
    @associated_list = associate_player_client(clients, player_names)
  end

  def run_game
    game.start 
    # create loop - break when game ends
    until game.over?    
      # print hand
      # figure out who's turn it is and ask what Rank they'd like to ask for
      # Which player?
      # play_round
      # output result based on player
    end
  end

  private

  def create_players(player_names)
    player_names.map {|player| Player.new(player)}
  end


  def associate_player_client(clients, player_names)
    clients.map.with_index { |name, index| [name, player_names[index]] }.to_h
  end
end