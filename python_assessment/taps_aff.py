# Given a list of locations and temperatures:
    # create field (what_to_wear)
    # if temp < 15C then add 'jumper'
    # if temp > OR == 15C then add 'tshirt'
    # write a script that reads a csv
    # fills in field (what_to_wear)
    # publishes a new file
    # copy whole file into output
    # add heading field
    # populate

import csv

# reference both files 
input_path = 'input.csv'
output_path = 'output.csv'


with open (input_path, 'r') as input_file:
        
       # create csv reader object & parse contents of the file
        reader = csv.reader(input_file)

        # store contents as list of lists
        rows = list(reader)
    
        # get the headers and add "what_to_wear"
        rows[0].append('what_to_wear')
            

# add the contents with the new data to the new csv
with open(output_path, 'w') as output_file:

    # create csv writer object 
    writer = csv.writer(output_file)

    # write all rows to output_file
    writer.writerows(rows)
  

         # foo.split(',')
            



        

            




    


