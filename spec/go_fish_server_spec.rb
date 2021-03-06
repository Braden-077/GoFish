# frozen_string_literal: true 

require 'go_fish_server'
require 'game_manager'
require 'go_fish_client'
require 'pry'
require 'socket'

describe GoFishServer do
  before(:each) do
    @sockets = []
    @server = GoFishServer.new
    @server.start
  end

  after(:each) do
    @server.stop
    @sockets.each do |client|
      client.close
    end
  end

  describe 'GoFishServer' do
    it "accepts new sockets and creates a game" do
      # binding.pry
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client2 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      @server.create_game_if_possible
      expect(@server.games.count).to be 1
    end
    
    it 'sends a message from the server to the client when a successful connection has occured'  do
      
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client1.capture_output
      expect(@server.sockets.count).to be 1
      expect(client1.output.chomp).to include "You've connected!"
    end
    
    it 'tests for capturing player input' do
      
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client1.provide_input('What I give it')
      message = @server.capture_input(@server.sockets.first)
      expect(message).to include 'What I give it'
    end
    
    
    it 'prompts a player for their name and associates it with the client' do
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client1.send_to_server('Braden')
      expect(client1.read_from_server.strip).to end_with 'Please enter your name:'
      @server.get_player_name
      expect(@server.player_names.first).to eq 'Braden'
    end
  
    it 'allows for the second user to input their name and still be refered to by name' do
      client1, client2 = GoFishClient.new(@server.port_number), GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client2.send_to_server('Caleb')
      @server.accept_new_client
      client1.send_to_server('Braden')
      @server.get_player_name
      @server.get_player_name
      expect(@server.player_names.first).to eq 'Braden'
      expect(@server.player_names.last).to eq 'Caleb'
    end
    
    it 'allows for the second user to input their name and still be refered to by name' do
      
      client1, client2 = GoFishClient.new(@server.port_number), GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client2.provide_input('Caleb')
      @server.accept_new_client
      client1.provide_input('Braden')
      @server.get_player_name
      @server.get_player_name
      expect(@server.player_names.first).to eq 'Braden'
      expect(@server.player_names.last).to eq 'Caleb'
    end
    
    it 'takes the provided names and creates a game using them' do
      
      client1, client2 = GoFishClient.new(@server.port_number), GoFishClient.new(@server.port_number)
      @server.accept_new_client
      client2.provide_input('Caleb')
      @server.accept_new_client
      client1.provide_input('Braden')
      @server.get_player_name
      @server.get_player_name
      @server.create_game_if_possible
      expect(@server.games.first.game.players.count).to eq 2
      expect(@server.games.first.game.players.first.name).to eq 'Braden'
      expect(@server.games.first.game.players.last.name).to eq 'Caleb'
    end
  end
  
  
  # Add more tests to make sure the game is being played
  # Unique connection messages 
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both sockets say they are ready to play
  #   ...
end