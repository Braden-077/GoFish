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

  def num_of_cards_in_hand
    hand.length
  end

  def has_card?(rank)
    hand.any? {|card| card.same_rank?(rank)}
  end

  def sort_hand
    hand.sort!
  end
end