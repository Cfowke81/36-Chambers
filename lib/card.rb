require_relative "deck"
require 'pry'
class Card

  attr_reader :suit, :rank

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
  end

  def face_card?
    ['J', 'Q', 'K'].include?(@rank)
  end

  def ace?
    ['A'].include?(@rank)
  end

  def show_card
    "#{rank}#{suit}"
  end
end
