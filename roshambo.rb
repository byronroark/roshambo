ENTRY = { "p" => "paper", "r" => "rock", "s" => "scissors" }
VALID_CHOICES = ENTRY.keys
COMPUTER_CHOICES = ENTRY.values

WINNERS = [["scissors", "paper"], ["paper", "rock"], ["rock", "scissors"]]
LOSERS = WINNERS.map(&:reverse)

class Roshambo
  def initialize(player_name)
    @player = player_name
    @engagements_player_wins = @engagements_computer_wins = @engagements_ties = 0
    @total_bouts_player_wins = 0
    @total_bouts_computer_wins = 0
    @total_bouts_ties = 0
    # load_leaderboard = 0
  end

  def play(winning_score)
    while @total_bouts_player_wins < winning_score && @total_bouts_computer_wins < winning_score
      while @engagements_player_wins < winning_score && @engagements_computer_wins < winning_score
        puts "#{@player} score: #{@total_bouts_player_wins} " +
        "Computer score: #{@total_bouts_computer_wins} " + "Ties: #{@engagements_ties}"

        player = player_choice
        computer = computer_choice
        puts "#{@player} chooses #{player.to_s}"
        puts "Computer chooses #{computer.to_s}"

        case player_outcome([player, computer])
        when :WIN
          puts "#{player.to_s} beats #{computer.to_s}, #{@player} WINS the round!"
          @engagements_player_wins += 1
        when :LOSE
          puts "#{computer.to_s} beats #{@player}, Computer WINS the round!"
          @engagements_computer_wins += 1
        else
          puts "It's a TIE! Choose again."
          @engagements_ties += 1
        end
      end
      puts "\nFinal score: player: #{@engagements_player_wins}, " + "computer: #{@engagements_computer_wins} (ties: #{@engagements_ties})"

      if @engagements_player_wins == 2
        puts "Player WINS!"
        @total_bouts_player_wins += 1
      elsif @engagements_computer_wins == 2
        puts "Computer WINS!"
        @total_bouts_computer_wins += 1
      else @engagements_ties == 2
        puts "It's a TIE!"
        @total_bouts_ties += 1
      end
      @engagements_player_wins = 0
      @engagements_computer_wins = 0
      @engagements_ties = 0
      # save_leaderboard
      # show_leaderboard
    end

  end


  def computer_choice
    ["rock", "paper", "scissors"].sample
  end

  # def save_leaderboard
  #   file = File.open("leaderboard.txt", "w")
  #   file.puts @total_bouts_player_wins
  #   file.puts @total_bouts_computer_wins
  #   file.close
  # end
  #
  # def load_leaderboard
  #   file = File.open("leaderboard.txt", "r")
  #   file.gets @total_bouts_player_wins
  #   file.gets @total_bouts_computer_wins
  # end
  #
  # def show_leaderboard
  #
  # end

  private

  def player_choice
    loop do
      print "Choose rock (r), paper (p) or scissors (s): "
      choice = gets.chomp.downcase
      return ENTRY[choice] if ENTRY.key?(choice)
      puts "That entry is invalid. Please re-enter"
    end
  end

  def player_outcome(plays)
    return :WIN  if WINNERS.include?(plays)
    return :LOSE if LOSERS.include?(plays)
    :TIE
  end
end

puts "Prepare to Roshambo! Please enter your name:"
player_name = gets.chomp.capitalize

if player_name.empty?
  puts "Player not detected, existing game."
  exit
else
  roshambo = Roshambo.new(player_name)
  roshambo.play(2)
end
