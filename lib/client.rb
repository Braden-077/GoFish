# frozen_string_literal: true

require 'socket'

class GoFishClient
  attr_reader :socket, :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
    sleep(0.01)
  end

  def provide_input(text)
    @socket.puts(text)
    sleep(0.01)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end