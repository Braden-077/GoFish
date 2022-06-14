# frozen_string_literal: true 

require 'game_manager'
require 'go_fish_server'

  describe 'GameManager' do
    before(:each) do
      @sockets = []
      @server = GoFishServer.new
    end

  after(:each) do
    @server.stop
    @sockets.each do |client|
    client.close
    end
  end
  
    describe '#initialize' do
      it 'initializes without error when provided no clients or players' do
        manager = GameManager.new(@server)
        expect(manager.clients).to be_empty
        expect(manager.player_names).to be_empty
        expect(manager.game.class).to eq Game
        expect(manager.game.players).to be_empty
        expect{ manager }.not_to raise_error
      end
    
      it 'associates players and clients correctly' do
        @server.start
        manager = GameManager.new(@server, [TCPSocket.new('localhost', 3000)], ['Braden'])
        expect(manager.clients).to be_one
        expect(manager.player_names).to be_one
        expect(manager.associated_list.length).to eq(1)
      end
    end

    describe '#run_game' do
      it 'prints out the player\'s hand to the correct client\'s socket', :focus do
        @server.start
        client1, client2 = GoFishClient.new(@server.port_number), GoFishClient.new(@server.port_number)
        @server.accept_new_client
        @server.accept_new_client
        client2.provide_input('Caleb')
        @server.get_player_name_for_tests
        client1.provide_input('Braden')
        @server.get_player_name_for_tests
        client1.capture_output
        client2.capture_output
        manager = @server.create_game_if_possible.first
        client1.provide_input('Caleb')
        client1.provide_input('A')
        manager.run_game_for_tests
        expect(client1.read_from_server).to include("It's your turn!")
      end
    end
  end