
import sys
import random
from enum import Enum

# closure to keep track of game count, player wins


def guessing_game(name='PlayerOne'):
    game_count = 0
    player_wins = 0
    percentage = 0.0

    def play_game():
        nonlocal name
        nonlocal percentage

        class Choice(Enum):
            ONE = "1"
            TWO = "2"
            THREE = "3"

        # Mapping dictionary for player's input
        player_choices = {'1': Choice.ONE.value,
                          '2': Choice.TWO.value, '3': Choice.THREE.value}

        player_choice_input = input(
            f"\n{name}, please guess which number I'm thinking of... 1, 2, or 3.\n\n")

        # Check if player_choice_input is empty
        if player_choice_input not in player_choices:
            # Print an error message and exit the program
            print(f"{name}, please enter 1, 2, or 3.\n")
            return play_game()
        else:
            # Process the user's input
            # Add your existing code here to handle the user's input
            player_choice = player_choices[player_choice_input]

            computerchoice = random.choice(list(Choice))
            computer = str(computerchoice.value)

            print(f"\n{name}, you chose {player_choice}.\n")
            print(f"I was thinking about the number {computer}.\n")

            player = int(player_choice)
            computer = int(computer)

            def decide_winner(player, computer):
                nonlocal player_wins
                if player == computer:
                    player_wins += 1
                    return (f"🎉 {name}, you win!\n")
                else:
                    return (f"🐍 Sorry, {name}, you lose...but idk why\n")

            game_result = decide_winner(player, computer)
            print(game_result)

            nonlocal game_count
            game_count += 1

            if (player_wins > 0):
                percentage = ((player_wins / game_count) * 100)

            print(f"Game count: {game_count}\n")
            print(f"{name}'s wins: {player_wins}\n")
            print(f"Your winning percentage: {percentage: .2f}%")

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
    return play_game


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

    guess_number = guessing_game(args.name)
    guess_number()
