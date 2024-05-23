# add some code to exclude temperatures too high for boston
# if the temperature does not exist or isn't viable then output
# "temperature doesn't exist" or throw EXCEPTION " temperature is not viable"

# test if location is in the csv file
# see if location exists in location column
# if not, throw an exception

# test if what_to_wear column is correct

import unittest
import csv
import os


class TestCsvProcessing(unittest.TestCase):
    def test_csv_processing(self):
        # Define input and expected output paths
        input_path = 'input.csv'
        output_path = 'output.csv'

        # Write some test data to input CSV file
        with open(input_path, 'w', newline='') as input_file:
            writer = csv.writer(input_file)
            writer.writerow(['Location', 'Temperature'])
            writer.writerow(['Glasgow', '14'])
            writer.writerow(['Edinburgh', '15'])
            writer.writerow(['Aberdeen', '16'])
            writer.writerow(['Boston', '52'])

        # Run the code to be tested
        base_temperature = 15
        with open(input_path, 'r') as input_file:
            reader = csv.reader(input_file)
            rows = list(reader)
            rows[0].append('what_to_wear')
            for row in rows[1:]:
                if int(row[1]) < base_temperature:
                    row.append('jumper')
                else:
                    row.append('tshirt')

        # Write output to a new CSV file
        with open(output_path, 'w', newline='') as output_file:
            writer = csv.writer(output_file)
            writer.writerows(rows)

        # Assert that the output file exists and has expected content
        self.assertTrue(os.path.exists(output_path))

        with open(output_path, 'r') as output_file:
            reader = csv.reader(output_file)
            rows = list(reader)
            self.assertEqual(rows[0][-1], 'what_to_wear')
            self.assertEqual(rows[1][-1], 'jumper')
            self.assertEqual(rows[2][-1], 'tshirt')
            self.assertEqual(rows[3][-1], 'tshirt')
            self.assertEqual(rows[4][-1], 'tshirt')
            self.assertEqual(rows[5][-1], 'tshirt')

        # Clean up: delete the generated output file
        os.remove(output_path)


if __name__ == '__main__':
    unittest.main()
