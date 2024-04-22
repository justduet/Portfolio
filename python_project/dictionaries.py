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
