def add_one(num):

    if (num <= 9):
        total = num + 1
        print(total)
        return add_one(total)


mynewtotal = add_one(0)
print(mynewtotal)
