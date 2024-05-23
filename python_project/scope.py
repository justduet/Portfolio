# global or local scope


# to use a global variable inside a function say "global"
# to use a parent variable inside a nested function say "nonlocal"


name = "Dave"
count = 1

# parent function
# nested function


def another():
    color = "blue"
    global count
    count += 1
    print(count)

    def greeting(firstname):
        nonlocal color
        color = "red"
        print(color)
        print(firstname)

    greeting("Dave")


another()
