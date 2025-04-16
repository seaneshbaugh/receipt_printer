require_relative "receipt_printer/receipt_item"
require_relative "receipt_printer/purchase_file_parser"
require_relative "receipt_printer/cli"

module ReceiptPrinter
  def self.print_receipt(items)
    sales_taxes = items.map(&:sales_tax).inject(:+) || 0.0

    total = items.map(&:total).inject(:+) || 0.0

    items.each do |item|
      puts item
    end

    puts "Sales Taxes: #{sprintf("%.2f", sales_taxes)}"

    puts "Total: #{sprintf("%.2f", total)}"
  end
end
