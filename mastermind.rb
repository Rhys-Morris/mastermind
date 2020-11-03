require 'colorize'

# WELCOME MESSAGE
puts "\nWelcome to Mastermind! A game where you attempt to break a code.
The mastermind will select a sequence of five colors from a choice of red, blue, yellow, green, orange and purple.
You must attempt to guess the correct sequence of colors within 10 turns, or the mastermind wins.
Good luck!\n"

class Mastermind 
    COLORS = ["r", "b", "y", "g", "c", "w"]
    MAX_TURNS = 10
    attr_reader :turn_count, :winner

    # Color printing variables
    @@r = "red".red
    @@b = "blue".blue
    @@y = "yellow".yellow
    @@g = "green".green
    @@c = "cyan".cyan
    @@w = "white".white

    def initialize
        @colors = []
        5.times do
            choice = COLORS.sample
            @colors.push(choice)
        end
        @turn_count = 0
        @winner = false
    end

    def explain_turn
        puts "\nTo make a guess enter your color selections, in order, seperated by spaces when prompted."
        puts"\n     r = #{@@r}, b = #{@@b}, y = #{@@y}, g = #{@@g}, c = #{@@c} w = #{@@w}"
        puts"\n     Example: r b b r g (#{@@r}, #{@@b}, #{@@b}, #{@@r}, #{@@g})"
    end

    def take_turn
        puts "\nMake a guess!"
        correct_entry = false
        while correct_entry == false do
            @guess = gets.chomp.split()
            correct_entry = true
            if @guess.length != 5
                correct_entry = false
            end
            for element in @guess do
                in_colors = COLORS.include?(element)
                if in_colors == false
                    correct_entry = false
                end
            end
            if correct_entry == false
                puts "\nInvalid entry! Try again:"
            end
        end
        @turn_count = @turn_count + 1
        check_guess(@guess)
    end

    private 

    def check_guess(guess)
        puts "\n------ Checking ------"
        correct_colors = 0
        correct_places = 0
        copy_colors = @colors.slice(0, @colors.length)
        i = 0
        j = 0
        5.times do
            if copy_colors.include?(guess[i])
                correct_colors = correct_colors + 1
                index = copy_colors.find_index(guess[i])
                copy_colors.delete_at(index)
            end
            i = i + 1
        end
        5.times do
            if guess[j] == @colors[j]
                correct_places = correct_places + 1
            end
            j = j + 1
        end
        puts "Turn: #{@turn_count} --> You selected "
        for value in guess do
            case value
            when "r"
                print "#{@@r} "
            when "b"
                print "#{@@b} "
            when "y"
                print "#{@@y} "
            when "g"
                print "#{@@g} "
            when "c"
                print "#{@@c} "
            when "w"
                print "#{@@w} "
            end
        end
        puts "\n#{correct_colors} of 5 correct colors"
        puts "#{correct_places} of 5 correct places"

        check_win(correct_places)
    end

    def check_win(correct_places)
        if correct_places == 5
            @winner = true
            puts "\nCode solved! You have beaten The Mastermind!"
            return
        end
        if @turn_count == MAX_TURNS
            puts "\nNo more guesses remain.\nThe Mastermind is victorious!"
            puts "The correct solution was: "
            for value in @colors do
                case value
                when "r"
                    print "#{@@r} "
                when "b"
                    print "#{@@b} "
                when "y"
                    print "#{@@y} "
                when "g"
                    print "#{@@g} "
                when "c"
                    print "#{@@c} "
                when "w"
                    print "#{@@w} "
                end
            end
            puts ""
            return
        end
    end
end

new_game = Mastermind.new
puts new_game.explain_turn
puts new_game.turn_count

while new_game.turn_count < 10
    new_game.take_turn
    if new_game.winner
        puts "\nThanks for playing!"
        return
    end
end