# frozen_string_literal: true 

require 'go_fish_client'
require 'go_fish_server'

describe GoFishClient do
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

  describe '#read_from_server' do
    it 'reads messages from the server to the client' do
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      message = client1.read_from_server
      expect(message).to include('Please enter your name:')
    end
  end

  describe '#print_message' do
    it 'prints messages from the server to the client' do
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      message = client1.read_from_server
      client1.print_message(message)
      expect(message).to include('Please enter your name:')
    end
  end

  describe '#requires_input?' do
    it 'returns true when a message includes a colon' do
      client1 = GoFishClient.new(@server.port_number)
      @server.accept_new_client
      message = client1.read_from_server
      expect(client1.requires_input?(message)).to be true
    end
  end
end