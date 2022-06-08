# frozen_string_literal: true 

require 'game'

describe Game do
  describe '#initialize' do
    it 'initializes without error' do
      game = Game.new
      expect{ game }.not_to raise_error
    end
  end
end