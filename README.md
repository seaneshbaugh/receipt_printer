# Receipt Printer

Simple command line program that takes list of purchased items, calculates sales tax, and then prints a receipt.


## Running the Program

The program can be run with the following command:

    $ bin/receipt_printer <purchase_file>

#### Input

Where `<purchase_file>` is the path to a file formatted like so:

```text
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

#### Output

The output for the above file will be a receipt like so:

```text
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.45
Sales Taxes: 7.80
Total: 98.28
```

#### Invalid Input

Lines that cannot be parsed will display a warning but will not cause the program to exit.

#### Exit Codes

The program will always return an exit code 0, regardless of invalid lines _unless_ the purchase file is not found, in which case the exit code will be 1.

## Tests

Tests can be run with the following command:

    $ rake test

## Linting

Run Rubocop with the following command:

    $ bundle exec rubocop
