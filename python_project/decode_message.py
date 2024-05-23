import re
from functools import reduce

file_to_decode = 'coding_qual_input.sorted.txt'


def parse_my_file(file_name):
    # sort the file in terminal
    new_dict = {}
    with open(file_name, 'r') as file:
        # read the lines
        text = file.readlines()
        # make file into a dictionary
        for row in text:
            row = list(re.split(r'\s+', row.strip()))
            if len(row) == 2:
                key, value = row
                new_dict[key] = value
                nums = list(new_dict.keys())
    return nums, new_dict


def pyramidify(numbers):
    # create a pyramid using incrementally longer lists
    pyramid = []
    step = 1
    while len(numbers) != 0:
        # add numbers to sublist up to the point of step
        pyramid.append(numbers[:step])
        # remove numbers in subset from numbers list
        numbers = numbers[step:]
        # every loop iteration add one more
        step += 1
    return pyramid


def decode_message(pyramid, dictionary):
    # access the last element in each sublist
    message = []
    for sublist in pyramid:
        #  create secret message from the last numbers of each sublist
        message.append(dictionary[sublist[-1]])
    return ' '.join(message)


# extract numbers and words from the file
indices, full_dict = parse_my_file(file_to_decode)

# make lists of numbers that grow by one each loop
pyramid = pyramidify(indices)

# retrieve the message based on the indices
final_message = decode_message(pyramid, full_dict)

print(final_message)

# add more descriptive variable names later
