# frozen_string_literal: true 

require_relative 'game_manager'
require 'socket'
require 'pry'

class GoFishServer
  attr_accessor :sockets, :games, :player_names
  def initialize
    @sockets = []
    @games = []
    @player_names = []
  end

  def port_number
    3000
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client
    socket = @server.accept
    sockets.push(socket)
    socket.puts "You've connected!"
    socket.puts "Please enter your name:"
  end

  def create_game_if_possible
    if sockets.count == 2
      games.push(GameManager.new(@server, sockets, player_names))
    end
  end

  def capture_input(socket)
    socket.read_nonblock(1000).chomp
    rescue IO::WaitReadable
  end

  def get_player_name
    sockets.each_with_index do |socket, index|
      next if player_names[index]
      begin
        player_names[index] = socket.read_nonblock(1000).strip
      rescue IO::WaitReadable
      end
    end
  end

  def stop
    @server.close if @server
  end
end
