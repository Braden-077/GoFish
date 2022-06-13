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
        manager = GameManager.new()
        expect(manager.clients).to be_empty
        expect(manager.player_names).to be_empty
        expect(manager.game.class).to eq Game
        expect(manager.game.players).to be_empty
        expect{ manager }.not_to raise_error
      end
    
      it 'associates players and clients correctly' do
        @server.start
        manager = GameManager.new([TCPSocket.new('localhost', 3000)], ['Braden'])
        expect(manager.clients).to be_one
        expect(manager.player_names).to be_one
        expect(manager.associated_list.length).to eq(1)
      end
    end
  end