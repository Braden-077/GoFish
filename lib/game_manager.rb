# frozen_string_literal: true 

require_relative 'game'

class GameManager
  attr_accessor :clients, :players, :game
  def initialize(clients = [], players = [])
    @clients = clients
    @players = players
    game = Game.new()
  end

  def associate(clients, players)
    
  end
end