entry = { p: "paper", r: "rock", s: "scissors" }
valid_choice = entry.keys
computer_choices = entry.values

WINNERS = [[:scissors, :paper], [:paper, :rock], [:rock, :scissors]]
LOSERS = WINNERS.map(&:reverse)

class Roshambo
  def initialize(player_name)
    @player = player_name
    @player_score = @computer_score = @ties = 0
  end

  def play(winning_score)
    while @player_score < winning_score && @computer_score < winning_score
      puts "#{@player} score: #{@player_score} " +
      "Computer score: #{@computer_score} " + "Ties: #{@ties}"

      player = player_choice
      computer = computer_choice
      puts "#{@player} chooses #{player.to_s}"
      puts "Computer chooses #{computer.to_s}"

      case player_outcome [player, computer]
      when :WIN
        puts "#{player.to_s} beats #{computer.to_s}, #{@player} WINS the round!"
        @player_score += 1
      when :LOSE
        puts "#{computer.to_s} beats #{@player}, Computer WINS the round!"
        @computer_score += 1
      else
        puts "It's a TIE! Choose again."
        @ties += 1
      end
    end
    puts "\nFinal score: player: #{@player_score}, " + "computer: #{@computer_score} (ties: #{@ties})"
    puts (@player_score == 2) ? "Player wins!" : "Yea! Computer wins!"
  end

  def computer_choice
    ["rock", "paper", "scissors"].sample
  end

  private

  def player_choice
    loop do
      print "Choose rock (r), paper (p) or scissors (s): "
      choice = gets.chomp.downcase
      return valid_choice[choice] if valid_choice.key?(choice)
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
player_name = gets.chomp.upcase

if player_name.empty?
  puts "Player not detected, existing game."
else
  roshambo = Roshambo.new(player_name)
  roshambo.play(3)
end
