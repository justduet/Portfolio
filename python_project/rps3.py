# Define the options for Rock, Paper, and Scissors.
# Generate a random choice for the computer's selection.
# Prompt the user to enter their choice.
# Compare the user's choice with the computer's choice to determine the winner.
# Display the result.

import sys
import random
from enum import Enum


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

        if player_choice == computerchoice:
            print('\n😮It\'s a tie!')
        elif player_choice == Choice.ROCK and computer == 'scissors':
            print(
                '🎉You win! Caveman use BIG ROCK \nto BREAK advanced tool\nnamed \'SCISSORS\' ')
        elif player_choice == Choice.PAPER and computer == 'rock':
            print('🎉You win! Even though rock\nwould TOTES crush paper')
        elif player_choice == Choice.SCISSORS and computer == 'paper':
            print('🎉You win! It takes BIG BRAIN ENERGY\nto use THAT move')
        else:
            print('🐍You lose...but idk why')

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
