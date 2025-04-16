require "test_helper"

describe ReceiptPrinter::ReceiptItem do
  describe "items subject to tax" do
    it "calculates the sales tax" do
      receipt_item = ReceiptPrinter::ReceiptItem.new("music CD", "other", 1, 14.99, false)

      _(receipt_item.sales_tax).must_equal 1.50
    end
  end

  describe "items not subject to tax" do
    it "calculates the sales tax as zero" do
      receipt_item = ReceiptPrinter::ReceiptItem.new("book", "book", 2, 12.49, false)

      _(receipt_item.sales_tax).must_equal 0.0
    end
  end

  describe "imported items" do
    it "calculates the sales tax" do
      receipt_item = ReceiptPrinter::ReceiptItem.new("chocolate bar", "food", 1, 1.0, true)

      _(receipt_item.sales_tax).must_equal 0.05
    end
  end
end
