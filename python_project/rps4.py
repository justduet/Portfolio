# Define the options for Rock, Paper, and Scissors.
# Generate a random choice for the computer's selection.
# Prompt the user to enter their choice.
# Compare the user's choice with the computer's choice to determine the winner.
# Display the result.

# created a global variable to count number of games

import sys
import random
from enum import Enum

game_count = 0


def play_rps():

    class Choice(Enum):
        ROCK = 'rock'
        PAPER = 'paper'
        SCISSORS = 'scissors'

    # Mapping dictionary for player's input
    player_choices = {'r': Choice.ROCK,
                      'p': Choice.PAPER, 's': Choice.SCISSORS}

    player_choice_input = input(
        '\nPlease enter a value:\n(r/p/s)\n')

    # Check if player_choice_input is empty
    if player_choice_input not in player_choices:
        # Print an error message and exit the program
        print('You must enter r, p, or s.')
        play_rps()
    else:
        # Process the user's input
        # Add your existing code here to handle the user's input
        player_choice = player_choices[player_choice_input]

        computerchoice = random.choice(list(Choice))
        computer = str(computerchoice.value)

        print('\nYou chose ' + player_choice.value + '.')
        print('Python chose ' + computer + '.')

        def decide_winner(player_choice, computerchoice):

            if player_choice == computerchoice:
                return ('\n😮It\'s a tie!')
            elif player_choice == Choice.ROCK and computer == 'scissors':
                return (
                    '🎉You win! \n\nCaveman use BIG ROCK \nto BREAK advanced tool\nnamed \'SCISSORS\' ')
            elif player_choice == Choice.PAPER and computer == 'rock':
                return ('🎉You win! \n\nEven though rock\nwould TOTES crush paper')
            elif player_choice == Choice.SCISSORS and computer == 'paper':
                return ('🎉You win! \n\nIt takes BIG BRAIN ENERGY\nto use THAT move')
            else:
                return ('🐍You lose...but idk why')

        game_result = decide_winner(player_choice, computerchoice)
        print(game_result)

        global game_count
        game_count += 1

        print("\nGame count: " + str(game_count))

        play_again = input(
            "\nDo you want to play again? \n(yes/no): ").lower()
        if play_again != 'yes':
            print("\n🥳🎉🤩")
            print("Thank you for playing!\n")
            # play_again = False
            sys.exit("Bye! 👋")
        else:
            play_rps()


play_rps()
