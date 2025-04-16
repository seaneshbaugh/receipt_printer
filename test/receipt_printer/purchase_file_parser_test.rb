require "test_helper"

describe ReceiptPrinter::PurchaseFileParser do
  describe "when all items are valid" do
    describe "test file #1" do
      it "parses the file and returns an Array of ReceiptItems" do
        purchase_file_parser = ReceiptPrinter::PurchaseFileParser.new(fixture_file("input_1.txt"))

        items = purchase_file_parser.parse!

        _(items.length).must_equal 3

        items.each do |item|
          _(item).must_be_instance_of ReceiptPrinter::ReceiptItem
        end

        _(items[0].quantity).must_equal 2
        _(items[0].name).must_equal "book"
        _(items[0].imported).must_equal false
        _(items[0].type).must_equal "book"
        _(items[0].price).must_equal 12.49

        _(items[1].quantity).must_equal 1
        _(items[1].name).must_equal "music CD"
        _(items[1].imported).must_equal false
        _(items[1].type).must_equal "other"
        _(items[1].price).must_equal 14.99

        _(items[2].quantity).must_equal 1
        _(items[2].name).must_equal "chocolate bar"
        _(items[2].imported).must_equal false
        _(items[2].type).must_equal "food"
        _(items[2].price).must_equal 0.85
      end
    end

    describe "test file #2" do
      it "parses the file and returns an Array of ReceiptItems" do
        purchase_file_parser = ReceiptPrinter::PurchaseFileParser.new(fixture_file("input_2.txt"))

        items = purchase_file_parser.parse!

        _(items.length).must_equal 2

        items.each do |item|
          _(item).must_be_instance_of ReceiptPrinter::ReceiptItem
        end

        _(items[0].quantity).must_equal 1
        _(items[0].name).must_equal "box of chocolates"
        _(items[0].imported).must_equal true
        _(items[0].type).must_equal "food"
        _(items[0].price).must_equal 10.00

        _(items[1].quantity).must_equal 1
        _(items[1].name).must_equal "bottle of perfume"
        _(items[1].imported).must_equal true
        _(items[1].type).must_equal "luxury"
        _(items[1].price).must_equal 47.50
      end
    end

    describe "test file #3" do
      it "parses the file and returns an Array of ReceiptItems" do
        purchase_file_parser = ReceiptPrinter::PurchaseFileParser.new(fixture_file("input_3.txt"))

        items = purchase_file_parser.parse!

        _(items.length).must_equal 4

        items.each do |item|
          _(item).must_be_instance_of ReceiptPrinter::ReceiptItem
        end

        _(items[0].quantity).must_equal 1
        _(items[0].name).must_equal "bottle of perfume"
        _(items[0].imported).must_equal true
        _(items[0].type).must_equal "luxury"
        _(items[0].price).must_equal 27.99

        _(items[1].quantity).must_equal 1
        _(items[1].name).must_equal "bottle of perfume"
        _(items[1].imported).must_equal false
        _(items[1].type).must_equal "luxury"
        _(items[1].price).must_equal 18.99

        _(items[2].quantity).must_equal 1
        _(items[2].name).must_equal "packet of headache pills"
        _(items[2].imported).must_equal false
        _(items[2].type).must_equal "medical"
        _(items[2].price).must_equal 9.75

        _(items[3].quantity).must_equal 3
        _(items[3].name).must_equal "boxes of chocolates"
        _(items[3].imported).must_equal true
        _(items[3].type).must_equal "food"
        _(items[3].price).must_equal 11.25
      end
    end
  end

  describe "some of the items are invalid" do
    it "prints a warning for each invalid line to $stderr while still returning valid lines" do
      old_stderr = $stderr

      $stderr = StringIO.new

      purchase_file_parser = ReceiptPrinter::PurchaseFileParser.new(fixture_file("input_4.txt"))

      items = purchase_file_parser.parse!

      _(items.length).must_equal 2

      _($stderr.string.lines[0]).must_include("Warning: line 2")
      _($stderr.string.lines[1]).must_include("Warning: line 3")
      _($stderr.string.lines[2]).must_include("Warning: line 4")

      $stderr = old_stderr
    end
  end

  describe "when there are no items in the file" do
    it "returns an empty array" do
      purchase_file_parser = ReceiptPrinter::PurchaseFileParser.new(fixture_file("input_5.txt"))

      items = purchase_file_parser.parse!

      _(items.length).must_equal 0
    end
  end
end
