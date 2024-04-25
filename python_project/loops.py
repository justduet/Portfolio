# while loops

value = 1
# while value <= 10:
#     print(value)
#     if value == 5:
#         break
#     value += 1

# while value <= 10:
#     value += 1
#     if value == 5:
#         continue
#     print(value)
# else:
#     print("Value is now equal to " + str(value))


# for loops

names = ["Dave", "Sara", "John"]
# for x in names:
#     print(x)

# for x in "Mississippi":
#     print(x)

# for x in names:
#     if x == "Sara":
#         break
#     print(x)

# for x in names:
#     if x == "Sara":
#         continue
#     print(x)

# ranges

# for x in range(2, 4):
#     print(x)

for x in range(0, 100, 5):
    print(x)
else:
    print("Glad that\'s over")

names = ["Dave", "Sara", "John"]
actions = ["codes", "eats", "sleeps"]

for name in names:
    for action in actions:
        print(name + " " + action + ".")

for action in actions:
    for name in names:
        print(name + " " + action + ".")


# Loop through two lists for the length of the shorter list

list1 = [1, 2, 3, 4]
list2 = ['a', 'b', 'c']

for item1, item2 in zip(list1, list2):
    print(item1, item2)

# Output:
# 1 a
# 2 b
# 3 c
