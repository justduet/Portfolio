import sys
from guess_number import guessing_game
from rps8 import rps


def arcade(name='PlayerOne'):
    welcome_back = False

    while True:
        if welcome_back == True:
            print(f"\n{name}, welcome back to the Arcade menu.")
        player_choice = input(
            f"\n{name}, welcome to the arcade!\n\nPlease choose a game:\n1 = Rock Paper Scissors\n2 = Guess My Number\n\nOr press \"x\" to exit the Arcade\n\n")

        if player_choice not in ["1", "2", "x"]:
            print(f"\n {name}, please enter 1, 2, or x.\n")
            return arcade(name)

        welcome_back = True

        if player_choice == "1":
            rock_paper_scissors = rps(name)
            rock_paper_scissors()
        elif (player_choice == "2"):
            guess_number = guessing_game(name)
            guess_number()
        else:
            sys.exit("okay, bye!")


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

arcade(args.name)
