module ReceiptPrinter
  class CLI
    def self.start(args)
      cli = new(args)

      cli.run!
    end

    def initialize(args)
      @purchase_file_path = args.first

      @exit_code = 0
    end

    def run!
      if File.exist?(@purchase_file_path)
        items = PurchaseFileParser.new(@purchase_file_path).parse!

        ReceiptPrinter.print_receipt(items)
      else
        @exit_code = 1
      end

      @exit_code
    end
  end
end
