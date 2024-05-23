# def print_x_times(parameter='loop', loop_amount=5):
#     x = 0
#     print(global_var)
#     while x < loop_amount:
#         print(x, parameter)
#         x += 1
#     return loop_amount


# global_var = 'hello'
# test = print_x_times('somethings', 4)
# print(test)

# refactored Pythagorean Theorem code


# def hypotenuse_calculator(side_a, side_b):
#     hypotenuse = (side_a ** 2 + side_b ** 2) ** (1/2)
#     return round(hypotenuse, 2)


# print(hypotenuse_calculator(5, 10))

# Shouter Function
# range can be used to iterate over a number
def shouter(output_string='What\'s your name', repitition=10):
    # while counter <= repitition:
    #     print(output_string.upper())
    #     counter += 1
    if repitition <= 10:
        for i in range(repitition):
            print(output_string.upper())
    else:
        print('you are too loud')
    return 'done'


print(shouter())
