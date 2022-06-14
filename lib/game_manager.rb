# frozen_string_literal: true 

require_relative 'game'
require_relative 'player'
require 'pry'

class GameManager
  attr_accessor :clients, :player_names, :game, :associated_list, :server
  def initialize(server, clients = [], player_names = [])
    @server = server
    @clients = clients
    @player_names = create_players(player_names)
    @game = Game.new(@player_names)
    @associated_list = associate_player_client(clients, @player_names)
  end

  def run_game
    game.start 
    until game.over?
      asked_player = beginning_message
      rank = ask_rank
      game.play_round(rank, game.turn_player, game.get_player(asked_player))
      puts game.round_output
    end
  end

  def beginning_message
    @associated_list.each_pair {|client, player| client.puts(player.hand.map(&:to_s)) ; puts}
    current_player.puts "It's your turn!\n Who would you like to ask for a card?"
    current_player.gets.chomp
  end

  def ask_rank
    current_player.puts "What rank would you like to ask for?"
    current_player.gets.chomp
  end

  private

  def current_player
    current = @associated_list.key(game.turn_player)
  end

  def create_players(player_names)
    player_names.map {|player| Player.new(player)}
  end


  def associate_player_client(clients, player_names)
    clients.map.with_index { |name, index| [name, player_names[index]] }.to_h
  end
end