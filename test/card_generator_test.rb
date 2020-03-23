require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/card_generator'

class CardGeneratorTest < Minitest::Test
  def setup
    @filename = "cards.txt"
    @card_generator = CardGenerator.new(@filename)
  end

  def test_it_exists
    assert_instance_of CardGenerator, @card_generator
  end

  def test_read_file
    assert_equal 52, @card_generator.read_file.length
  end

  def test_format_cards
    52.times do |card|
      assert_instance_of Card, @card_generator.cards[card]
    end

    assert_equal 52, @card_generator.cards.length
  end

  def test_cards_are_unique
    suit_value_rank = @card_generator.cards.map { |card| [card.suit, card.value, card.rank]  }

    assert_equal suit_value_rank, suit_value_rank.uniq
  end
end
