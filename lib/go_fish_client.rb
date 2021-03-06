# frozen_string_literal: true

require 'socket'

class GoFishClient
  attr_reader :socket, :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
    sleep(0.01)
  end

  def read_from_server
    sleep(0.01)
    @output = @socket.read_nonblock(1000)
  rescue IO::WaitReadable
    @output = ''
  end

  def print_message(message)
    return if message.empty?
    puts(message)
  end
  
  def send_to_server(message)
    @socket.puts(message)
  end

  def requires_input?(message)
    message.include?(':') || message.include?('?')
  end

  def close
    @socket.close if @socket
  end
end