# frozen_string_literal: true 

require 'game_manager'
require 'go_fish_server'

  describe 'GameManager' do
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
        manager = GameManager.new(@server, [TCPSocket.new('localhost', 3000)], ['Braden'])
        expect(manager.clients).to be_one
        expect(manager.player_names).to be_one
        expect(manager.associated_list.length).to eq(1)
      end
    end

    describe '#run_game' do
      it 'runs a game until all 13 books have been collected' do
        clients = setup_server_with_clients(['Caleb', 'Braden'])
        manager = @server.create_game_if_possible.first
        manager.game.deck.cards = []
        manager.game.players.first.books = %w( 2 3 4 5 6 7 8 9 10 )
        manager.game.players.last.books = %w( J Q K )
        manager.associated_list.values[0].hand = [Card.new('A', 'S'), Card.new('A', 'C'), Card.new('A', 'D')]
        manager.associated_list.values[1].hand = [Card.new('A', 'H')]
        clients[0].send_to_server('Braden')
        clients[0].send_to_server('A')
        manager.game.started = true
        manager.run_game 
        expect(manager.game.over?).to be true
        expect(manager.game.players)
      end
    end

    def setup_server_with_clients(player_names)
      player_names.map do |player_name|
        client = GoFishClient.new(3000)
        @server.accept_new_client
        client.send_to_server(player_name)
        @server.get_player_name
        client.read_from_server
        client
      end
    end
end