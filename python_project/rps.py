# Define the options for Rock, Paper, and Scissors.
# Generate a random choice for the computer's selection.
# Prompt the user to enter their choice.
# Compare the user's choice with the computer's choice to determine the winner.
# Display the result.

import math
import sys
import random
from enum import Enum


class Choice(Enum):
    ROCK = 'rock'
    PAPER = 'paper'
    SCISSORS = 'scissors'


 # Mapping dictionary for player's input
player_choices = {'r': Choice.ROCK,
                  'p': Choice.PAPER, 's': Choice.SCISSORS}


while True:
    print("")

    player_choice_input = input(
        'Please enter a value:\n(r/p/s)\n').lower()

    # Get player's choice from the mapping dictionary
    player_choice = player_choices[player_choice_input]

    computerchoice = random.choice(list(Choice))
    computer = str(computerchoice.value)

    print('')
    print('You chose ' + player_choice.value + '.')
    print('Python chose ' + computer + '.')
    print('')
    if player_choice == computerchoice:
        print('It\'s a tie!')
    if player_choice == Choice.ROCK:
        print('do something')
    elif player_choice == 'p':
        print('do something else')
    elif player_choice == 's':
        print('hello dolly')
    else:
        sys.exit('You must enter r, p, or s.')

    play_again = input("Do you want to play again? (yes/no): ").lower()
    if play_again != 'yes':
        break
