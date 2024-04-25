# functions in python
# parameters never change but arguments can change every function call


def hello_world():
    print("Hello world!")


hello_world()


def sum(num1=0, num2=0):
    if (type(num1) is not int or type(num2) is not int):
        return 0
    total = num1 + num2
    print(total)
    return total


sum(3, 8)

# passing in multiple arguments without knowing specific number


def multiple_items(*args):
    print(args)
    print(type(args))


multiple_items("Dave", "John", "Sara")


def mult_named_items(**kwargs):
    print(kwargs)
    print(type(kwargs))


mult_named_items(first="Dave", last="Gray")
