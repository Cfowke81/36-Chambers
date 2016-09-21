require "spec_helper"
require 'pry'
RSpec.describe Deck do
  let(:deck) { Deck.new } # Creates a variable that can be used for tests

  describe "initialize" do
    it "builds a deck of 52 cards" do
      expect(deck.cards.size).to eq 52
    end

    it "creates unique cards" do
      expect(deck.cards.uniq.size).to eq 52
    end

    it "shuffles deck after being built" do
      sorted_deck = deck.cards.sort do |card_a, card_b|
        card_b.rank.to_i <=> card_a.rank.to_i
      end

      expect(sorted_deck).to_not eq deck.cards
      expect(sorted_deck[0].rank).to be_between '0', '11'
      expect(['♦', '♣', '♠', '♥']).to include sorted_deck[0].suit
      expect(sorted_deck[1].rank).to be_between '0', '11'
      expect(['♦', '♣', '♠', '♥']).to include sorted_deck[1].suit
    end
  end

  describe "#deal" do
    it "removes correct number of cards" do
      start_size = deck.cards.size
      finish_size = start_size - 2

      deck.deal(2)

      expect(deck.cards.size).to eq finish_size
    end

    it "deals the top card in the deck" do
      correct_card = deck.cards[-1]
      expect(deck.deal(1)).to eq [correct_card]
    end
  end

  describe "#draw!" do
    it "provides the player/dealer with one more card" do
      correct_card = deck.cards[-1]
      expect(deck.draw!).to eq correct_card
    end
  end
end
