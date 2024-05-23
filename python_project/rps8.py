# Define the options for Rock, Paper, and Scissors.
# Generate a random choice for the computer's selection.
# Prompt the user to enter their choice.
# Compare the user's choice with the computer's choice to determine the winner.
# Display the result.

# add a name argument

import sys
import random
from enum import Enum


def rps(name='PlayerOne'):
    game_count = 0
    player_wins = 0
    python_wins = 0

    def play_rps():
        nonlocal name
        nonlocal player_wins
        nonlocal python_wins

        class Choice(Enum):
            ROCK = 'rock'
            PAPER = 'paper'
            SCISSORS = 'scissors'

        # Mapping dictionary for player's input
        player_choices = {'r': Choice.ROCK.value,
                          'p': Choice.PAPER.value, 's': Choice.SCISSORS.value}

        player_choice_input = input(
            f"\n{name}, please enter a value:\n(r/p/s)\n")

        # Check if player_choice_input is empty
        if player_choice_input not in player_choices:
            # Print an error message and exit the program
            print(f"{name}, please enter r, p, or s.")
            play_rps()
        else:
            # Process the user's input
            # Add your existing code here to handle the user's input
            player_choice = player_choices[player_choice_input]

            computerchoice = random.choice(list(Choice))
            computer = str(computerchoice.value)

            print(f"\n{name}, you chose {str(player_choice)}.")
            print(f'Python chose {str(computer)}.')

            def decide_winner(player_choice, computer):
                nonlocal player_wins
                nonlocal python_wins
                if player_choice == computer:
                    return ('\n😮It\'s a tie!')
                elif player_choice == Choice.ROCK.value and computer == 'scissors':
                    player_wins += 1
                    return (
                        f"🎉 {name}, you win! \n\nCaveman use BIG ROCK \nto BREAK advanced tool\nnamed \'SCISSORS\' ")
                elif player_choice == Choice.PAPER.value and computer == 'rock':
                    player_wins += 1
                    return (f"🎉 {name}, you win! \n\nEven though rock\nwould TOTES crush paper")
                elif player_choice == Choice.SCISSORS.value and computer == 'paper':
                    player_wins += 1
                    return (f"🎉 {name}, you win!  \n\nIt takes BIG BRAIN ENERGY\nto use THAT move")
                else:
                    python_wins += 1
                    return (f"\n🐍 Sorry, {name}, you lose...but idk why")

            game_result = decide_winner(player_choice, computer)
            print(game_result)

            nonlocal game_count
            game_count += 1

            print(f"\nGame count: {game_count}")
            print(f"\n{name}'s wins: {player_wins}")
            print(f"\nPython wins: {python_wins}")

            play_again = input(
                f"\nDo you want to play again, {name}? \n(yes/no): ").lower()
            if play_again != 'yes':
                print("\n🥳🎉🤩")
                print("Thank you for playing!\n")
                # play_again = False
                if __name__ == "__main__":
                    sys.exit(f"Bye {name}! 👋")
            else:
                return
    return play_rps


if __name__ == "__main__":

    import argparse

    parser = argparse.ArgumentParser(
        description="Provides a personalized game experience"
    )

    parser.add_argument(
        "-n", "--name", metavar="name",
        required=True, help="The name of the person playing the game."
    )

    args = parser.parse_args()

    rock_paper_scissors = rps(args.name)
    rock_paper_scissors()
