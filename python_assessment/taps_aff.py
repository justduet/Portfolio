import csv

# reference both files
input_path = 'input.csv'
output_path = 'output.csv'
base_temperature = 15


with open(input_path, 'r') as input_file:

    # create csv reader object & parse contents of the file
    reader = csv.reader(input_file)

    # store contents as list of lists
    rows = list(reader)

    # get the headers and add "what_to_wear"
    rows[0].append('what_to_wear')

    # access rows from 1-end
    # add conditional statements
    # create new column
    for row in rows[1:]:
        if int(row[1]) < base_temperature:
            row.append('jumper')

        elif int(row[1]) >= base_temperature:
            row.append('tshirt')


# add the contents with the new data to the new csv
with open(output_path, 'w') as output_file:

    # create csv writer object
    writer = csv.writer(output_file)

    # write all rows to output_file
    writer.writerows(rows)
