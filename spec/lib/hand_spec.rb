require "spec_helper"
require 'pry'
RSpec.describe Hand do
  let!(:hand_1) { Hand.new([Card.new('A', '♣'), Card.new('J','♥')]) }
  let!(:hand_2) { Hand.new([Card.new('A', '♣'), Card.new('4', '♣')]) }
  let!(:hand_3) { Hand.new([Card.new('Q', '♣'), Card.new('J', '♥')]) }

  let(:hit_1) { Card.new('J','♥') }
  let(:hit_2) { Card.new('A','♥') }
  let(:hit_3) { Card.new('10','♣') }

  describe "#hit" do
    it "it draws one card and adds the player/dealer's hand" do
      expect(hand_1.hit(hit_1)).to eq hand_1.cards
      expect(hand_2.hit(hit_2)).to eq hand_2.cards
      expect(hand_3.hit(hit_3)).to eq hand_3.cards
    end

    it "will include the new card passed to it" do
      expect(hand_1.hit(hit_1)).to include hit_1
      expect(hand_2.hit(hit_2)).to include hit_2
      expect(hand_3.hit(hit_3)).to include hit_3
    end
  end

  describe "#display_hand" do
    it "displays the current hand" do
      expect(hand_1.display_hand).to eq('A♣, J♥')
      expect(hand_2.display_hand).to eq('A♣, 4♣')
      expect(hand_3.display_hand).to eq('Q♣, J♥')
    end
  end

  describe "#display_hit" do
    it "displays the 'hit' card" do
      expect(hand_1.hit(hit_1).display_hit).to eq('J♥')
      expect(hand_2.hit(hit_2).display_hit).to eq('A♥')
      expect(hand_3.hit(hit_3).display_hit).to eq('10♣')
    end
  end

  describe "#score" do
    it "adds up the score of cards dealt" do
      expect(hand_1.score).to eq(21)
      expect(hand_2.score).to eq(15)
      expect(hand_3.score).to eq(20)
    end

    it "recalculates the score if the player 'hits'" do
      expect(hand_1.hit(hit_1).score).to eq(21)
      expect(hand_2.hit(hit_2).score).to eq(15)
      expect(hand_3.hit(hit_2).score).to eq(21)
      expect(hand_3.hit(hit_3).score).to eq(30)
    end
  end
end
