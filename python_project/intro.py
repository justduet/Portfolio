# Shortcuts:
# CMD + , = settings
# CMD + / = comment chunk
# CMD + d = select multiple instances of word to bulk change
# formatting: autopep8 --in-place <filename>.py
# 3 dots, clear terminal


# Meanings:
# a statement is an operation on a value
# operators (assignment, arithmetic)
# floor division //
# 2 ** 5 = 32
# 42 == 41 False


line01 = '********************'  # header / footer
line02 = '*                  *'  # re-use
line03 = '*     WELCOME!     *'


# stars with a blank line
print('')
print(line01)
print(line02)
print(line03)
print(line02)
print(line01)


# Variables and Operators
meaning = 42
print('')

# if meaning > 10:
#     print('right on!')
# else:
#     print('not today :(')

# Ternary Operator
print('right on') if meaning > 10 else print('not today')
