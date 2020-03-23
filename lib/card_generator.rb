class CardGenerator

  attr_reader :filename
  def initialize(filename)
    @filename = filename
    @cards = []
  end

  def read_file
    cards_array = []
    File.open("./lib/#{@filename}", "r") do |file|

      file.readlines().each do |line|
        cards_array.push(line)
      end
      file.close
      @cards = cards_array
    end
  end

  def format_to_cards
    @cards.map! { |card| card.chomp('')}
    @cards.map! { |card| card.split(',')}
    @cards.map! { |card| card.map! { |card| card.strip}}

    values = @cards.map { |card| card[0]}
    suits = @cards.map { |card| card[1].to_sym}
    ranks = @cards.map { |card| card[2].to_i}

    card_array = [suits,values,ranks].transpose
    @cards = card_array.map { |card| Card.new(card[0], card[1], card[2])}
  end

  def cards
    read_file
    format_to_cards
  end
end
