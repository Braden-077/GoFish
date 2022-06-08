# frozen_string_literal: true 

class Player
  attr_accessor :name, :hand, :books
  def initialize(name = '', hand = [], books = [])
    @name = name
    @hand = hand 
    @books = books
  end

  def take(cards)
    hand.push([cards]).flatten!
  end
end