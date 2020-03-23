class GameSetup

  def initialize(filename)
    @filename = filename
  end

  def make_standard_deck
    standard_deck = CardGenerator.new(@filename).cards
  end

  def make_player_decks
    standard_deck = make_standard_deck.shuffle!
    deck1 = Deck.new(standard_deck[0..25])
    deck2 = Deck.new(standard_deck[26..-1])
    player_decks = [deck1, deck2]
  end

  def make_players
    player_decks = make_player_decks
    player1 = Player.new("Megan", player_decks[0])
    player2 = Player.new("Aurora", player_decks[1])
    players = [player1, player2]
  end

  def start
    players = make_players
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are #{players[0].name} and #{players[1].name}"
    puts "Type 'GO' to start the game!"
    puts "------------------------------------------------------------------"
    user_input = gets.chomp

    if user_input == "GO"
      i = 1

      until players[0].has_lost? or players[1].has_lost?

        if i > 1000000
           puts "---- DRAW ---- "
           puts "#{players[0].deck.cards.length} player 1 cards"
           puts "#{players[1].deck.cards.length} player 2 cards"
           break
        end

        if i % 25 == 0
          players[0].deck.cards.shuffle!
          players[1].deck.cards.shuffle!
        end

        turn = Turn.new(players[0], players[1])
        turn_number = "Turn " + "#{i}"

        if turn.type == :basic
          puts "#{turn_number}: #{turn.winner.name} won 2 cards"
        elsif turn.type == :war
          puts "#{turn_number}: WAR - #{turn.winner.name} won 6 cards"
        elsif turn.type == :mutually_assured_destruction
          puts "#{turn_number}: *mutually assured destruction* 6 cards removed from play"
        end

        turn_winner = turn.winner
        turn.pile_cards
        turn.award_spoils(turn_winner)

        i += 1
      end

      if players[0].has_lost?
        puts "*~*~*~* #{players[1].name} has won the game! *~*~*~*"
      elsif players[1].has_lost?
        puts "*~*~*~* #{players[0].name} has won the game! *~*~*~*"
      end

    end
  end

end
