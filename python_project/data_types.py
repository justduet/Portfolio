# Data Types
# string, boolean, integer, float

# String literal assignment
import math
first = "Annie"
last = "Felt"
# print(type(first))
# print(type(first) == str)
# print(isinstance(first, str))

# constructor function
# pizza = str("Pepperoni")
# print(type(pizza))
# print(type(pizza) == str)
# print(isinstance(pizza, str))

# concatenation
fullname = first + " " + last
print(fullname)

fullname += "!"

# casting a number to a string
decade = str(1980)
print(type(decade))

statement = "I like rock music from the " + decade + "s."
print(statement)

# Multiple lines
# multiline = '''
# Hey, how are you?
# I was just checking in.
#          All good?
# '''
# print(multiline)

# escaping special characters
# tabs, etc
# sentence = 'I\'m back at work.\tHey!\n\nWhere\'s this at\\located?'
# print(sentence)

# string methods
# print(first)
# print(first.lower())
# print(first.upper())
# print(first)

# print(multiline.title())
# print(multiline.replace("good", "ok"))

# print(len(multiline))
# multiline += "      "
# print(len(multiline))
# multiline = "      " + multiline
# print(len(multiline))

# print(multiline.strip())
# print(multiline.rstrip())

# build a menu
title = "menu".upper()
print(title.center(20, "="))
print("Coffee".ljust(16, ".") + "$2".rjust(4))
print("Tea".ljust(16, ".") + "$1".rjust(4))
print("Muffin".ljust(16, ".") + "$3".rjust(4))
print("Cake".ljust(16, ".") + "$4".rjust(4))

print("")
# string index values
# second value
print(first[1])
# last value of a string
print(first[-1])
# ranges can be important
print(first[1:])

# some methods return boolean data
print(first.startswith("A"))
print(first.endswith("Z"))

# boolean data type
myvalue = False
x = bool(False)  # constructor
print(type(x))
print(isinstance(myvalue, bool))


# numeric data types

# integer type
price = 100
best_price = int(80)
print(type(price))
print(isinstance(best_price, int))

# float type
gpa = 3.28
y = float(1.14)
print(type(gpa))

# complex type
comp_value = 5+3j
print(type(comp_value))
print(comp_value.real)
print(comp_value.imag)

# built-in functions for numbers
print(abs(gpa))
print(round(gpa))
print(round(gpa, 1))

# math module
print(math.pi)
print(math.sqrt(64))
print(math.ceil(gpa))
print(math.floor(gpa))

# casting a string to a number
zipcode = "10001"
zip_value = int(zipcode)
print(type(zip_value))

# error if you attempt to cast incorrect data
# zip_value = int("New York")
