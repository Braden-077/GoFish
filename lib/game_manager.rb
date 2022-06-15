# frozen_string_literal: true 

require_relative 'game'
require_relative 'player'
require 'pry'

class GameManager
  attr_accessor :clients, :players, :game, :associated_list, :server
  def initialize(server, clients = [], player_names = [])
    @server = server
    @clients = clients
    @players = create_players(player_names)
    @game = Game.new(@players)
    @associated_list = associate_player_client(clients, @players)
  end

  def run_game
    game.start 
    until game.over?
      asked_player = beginning_message
      rank = ask_rank
      game.play_round(rank, game.get_player(asked_player))
      puts game.round_output
      # output correct message to correct player
    end
  end

  def beginning_message
    @associated_list.each_pair {|client, player| client.puts(player.hand.map(&:to_s))}
    @associated_list.each_key {|client| client.puts } # Purely for CLI
    current_player_socket.puts "It's your turn!\nWho would you like to ask for a card?"
    puts "It's #{current_player_name}'s turn. Go #{current_player_name}!"
    current_player_socket.gets.chomp
  end

  def ask_rank
    current_player_socket.puts "What rank would you like to ask for?"
    current_player_socket.gets.chomp
  end

  private

  def current_player_socket
    @associated_list.key(game.turn_player)
  end

  def current_player_name
    game.turn_player.name
  end

  def create_players(player_names)
    player_names.map {|player| Player.new(player)}
  end


  def associate_player_client(clients, player_names)
    clients.map.with_index { |socket, index| [socket, player_names[index]] }.to_h
  end
end