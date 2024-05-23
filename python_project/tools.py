# f strings
# user_name = 'Bob'
# user_age = 10
# user_information = 'Bob is 10 years old.'

# good_approach = f'{user_name} is {user_age} years old.'
# print(good_approach)

# single-line if statements
user_age = 18
user_name = 'Anna'
user_status = 'Adult' if user_age >= 18 else 'Child'
# if user_age < 18:
#     user_status = 'Child'
# else:
#     user_Status = 'Adult'

# you can put the single line if statements
print(f'{user_name} is {user_age} years old. The person is a {user_status}')

# list comprehension (powerful tool)

# simple_list = [f'{j}{i}' for i in range(
#     0, 11, 1) for j in ('a', 'b', 'c') if j == 'a']
# # for i in range(0, 11, 1):
# #     simple_list.append(i)
# print(simple_list)


# lambda functions (returns automatically)

# def double_value(num):
#     return num * 2
# print(double_value(10))

# def double_value(num): return num * 2


# # some functions want a function as an argument
# random_list = [('Anna', 25), ('Paul', 40), ('Lisa', 10)]

# sorted_list = sorted(random_list, key=lambda user_tuple: user_tuple[1])

# print(sorted_list)

# print(double_value(10))

# EXERCISE
# battle ship list comprehension

# 2 ways

battle_ship_board = [f'{j}{i}' for i in range(1, 5, 1) for j in (
    'A', 'B', 'C', 'D', 'E')]
battle_ship_board.remove('C3')
print(battle_ship_board)

battle_ship_board = [f'{j}{i}' for i in range(1, 5, 1) for j in (
    'A', 'B', 'C', 'D', 'E') if f'{j}{i}' != 'C3']
battle_ship_board.remove('C3')
print(battle_ship_board)
