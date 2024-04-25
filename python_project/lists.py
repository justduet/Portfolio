# collections of data in python

list_of_names = ['Dave', 'Sarah', 'Joy']

# check if a value is in the list_of_names
print('Dave' in list_of_names)
print('shelly' in list_of_names)

# you can get values from certain indexes
print(list_of_names[2])
print(list_of_names[-2])

# get the index of values in the list_of_names
print(list_of_names.index('Joy'), 'hello')

# print a range
print(list_of_names[0:2])
print(list_of_names[1:])

# get the length
print(len(list_of_names))

# add things to list_of_names
list_of_names.append('Bruv')

# adding a list_of_names to your list_of_names
list_of_names += ['yo']

list_of_names.extend(['echo, delta'])

# inserting values at certain indexes
list_of_names.insert(0, 'Bob')
print(list_of_names)

list_of_names[2:2] = ['Eddie', 'Alex']
print(list_of_names)

# slice
list_of_names[1:3] = ['Rob', 'HOI']

# remove method
list_of_names.remove('Sarah')
print(list_of_names)

# pop method
print(list_of_names.pop())

# delete a specific item at an index
del list_of_names[0]

# empty list_of_names
list_of_names.clear()
print(list_of_names)

# sorting list_of_names alphabetically
list_of_names.sort(key=str.lower)
print(list_of_names)

# reversing order of original list_of_names
nums = [4, 42, 34, 1, 2, 54]
nums.reverse()
print(nums)

# sorting list_of_names into descending order
nums.sort(reverse=True)
print(nums)

# global way of only sorting for a specific function
# original list_of_names is not modified
print(sorted(nums, reverse=True))
print(nums)

# making copies
numscopy = nums.copy()
print(numscopy)
nums = [0, 1, 2, 3, 4, 5]
mynums = list(nums)
print(mynums)
mycopy = nums[:]

# check the type of the list
print(type(nums))

# Tuples - data doesn't change, order doesn't change

mytuple = tuple(('Hello', 42, True))
anothertuple = (1, 2, 3)

print(type(mytuple))

# copy tuple

newlist = list(mytuple)
newlist.append('Neil')

# tuple constructor

newtuple = tuple(newlist)

# unpacking a tuple
# this tuple will hold
# the values of original anothertuple
anothertuple = (1, 2, 3)
(one, two, *hey) = anothertuple
print(one)
print(two)
print(hey)

# check which methods are available for lists and tuples
print(newlist.append('world'))
