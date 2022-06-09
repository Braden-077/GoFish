# frozen_string_literal: true 

require_relative 'go_fish_server'

server = GoFishServer.new
server.start

while true do
  begin
    server.accept_new_client
    server.get_player_name
    server.create_game_if_possible
    game = server.games[0]
  rescue
    server.stop
  end
end