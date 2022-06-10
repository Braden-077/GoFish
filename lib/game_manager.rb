# frozen_string_literal: true 

require_relative 'game'
require_relative 'player'
require 'pry'

class GameManager
  attr_accessor :clients, :players, :game, :associated_list
  def initialize(clients = [], players = [])
    @clients = clients
    @players = create_players(players)
    @game = Game.new(@players)
    @associated_list = associate_player_client(clients, players)
  end

  private

  def create_players(players)
    new_players = players.map {|player| Player.new(player)}
    new_players
  end


  def associate_player_client(clients, players)
    Hash[clients.zip(players)]
  end
end