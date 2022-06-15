# frozen_string_literal: true 

require 'pry'
require_relative 'card'

class Player
  attr_accessor :name, :hand, :books
  def initialize(name = '', hand = [], books = [])
    @name = name
    @hand = hand
    @books = books
  end

  def take(cards)
    hand.push([cards]).flatten!
    sort_hand!
  end

  def card_count
    hand.length
  end

  def has_card?(rank)
    hand.any? {|card| card.same_rank?(rank)}
  end

  def sort_hand!
    hand.sort!
  end

  def give(rank)
    cards_to_give = hand.filter {|card| card.same_rank?(rank)}
    hand.delete_if {|card| cards_to_give.include?(card)}
    cards_to_give
  end

  def check_for_book(rank)
    cards_to_check = hand.filter {|card| card.same_rank?(rank)}
    if cards_to_check.length == 4
      hand.delete_if {|card| cards_to_check.count == 4 }
      books.push(cards_to_check.first.rank)
    end
  end
end