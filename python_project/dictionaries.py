# Dictionaries

# used to hold key value pairs

band = {"vocals": "Plant",
        "guitar": "Page"}

# dictionary constructor
band2 = dict(vocals="Plant", guitar="Page")
print(band)
print(band2)
print(type(band))
print(len(band))

# Accessing items
print(band["vocals"])
print(band.get("guitar"))

# return a view object that displays all keys or values
# you can turn this into a list by doing list(@(*#&)
keys = band.keys()
print(keys)
print(band.values)

# list of key/value pairs as tuples
print(band.items())

# verify that a key exists
print("guitar" in band)
print("triangle" in band)

# change values
band["vocals"] = "Coverdale"
band.update({"bass": "JPJ"})

print(band)

# remove items
print("")
print(band.pop("bass"))
print(band)

band["drums"] = "Bonham"
print(band)

print(band.popitem())  # returns tuple
print(band)

# delete and clear
band["drums"] = "Bonham"
del band["drums"]
print(band)

# delete whole dict
band2.clear()
print(band2)

del band2

# copy dictionaries

# band2 = band  # creates a reference
# print("Bad copy!")
# print(band2)
# print(band)

# band2["drums"] = "Dave"
# print(band)

band2 = band.copy()
band2["drums"] = "Dave"
print("Good copy!")
print(band)
print(band2)

# or use the dict constructor function
band3 = dict(band)
print("Good copy!")

# nested dictionaries
member1 = {"name": "Plant",
           "instrument": "vocals"}
member2 = {"name": "Page",
           "instrument": "guitar"}
band = {
    "member1": member1,
    "member2": member2
}

print(band)

# access values
print(band["member1"]["name"])
print("")
print("-------------")
print("")

# Sets final data collection type
nums = {1, 2, 3, 4}
nums2 = set((1, 2, 3, 4))
print(nums)
print(nums2)
print(type(nums))
print(len(nums))

# no duplicates allowed
nums = {1, 2, 2, 3}
print(nums)

# True is a dupe of 1, False is a dupe of 0
nums = {1, True, 2, False, 3, 4, 0}
print(nums)

# check if a value is in a set
print(1 in nums)

# but you cannot refer to an element in a set with an index or a key

# add an element to a set
nums.add(8)
print(nums)

# add elements form one set to another
morenums = {5, 6, 7}
nums.update(morenums)
print(nums)

# you can use update with lists, tuples, and dictionaries

# merge two sets to create a new set
one = {1, 2, 3}
two = {5, 6, 7}

mynewset = one.union(two)
print(mynewset)


# keep only duplicates
one = {1, 2, 3}
two = {2, 3, 4}

one.intersection_update(two)
print(one)

# keep everything except the duplicates
one = {1, 2, 3}
two = {2, 3, 4}

one.symmetric_difference_update(two)
print(one)
