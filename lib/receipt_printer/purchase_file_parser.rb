module ReceiptPrinter
  class PurchaseFileParser
    ITEM_LINE_PATTERN = /(\d+) (imported )?(.+) at (\d+\.\d\d)/.freeze
    # In a real scenario we'd have some sort of database of categories and the
    # types of products that fit into them. For now a hash will do.
    ITEM_CATEGORIES = {
      "book" => %w(book),
      "food" => %w(burger chocolate grapes hummus steak),
      "medical" => %w(bandages gauze pills),
      "luxury" => %w(perfume)
    }.freeze
    DEFAULT_CATEGORY = "other".freeze

    attr_reader :purchase_file_path, :items

    def initialize(purchase_file_path)
      @purchase_file_path = purchase_file_path

      @lines = File.readlines(@purchase_file_path)

      @items = []
    end

    def parse!
      @lines.each_with_index do |line, index|
        matches = ITEM_LINE_PATTERN.match(line)

        if matches
          quantity = matches[1].to_i
          imported = !matches[2].nil?
          name = matches[3]
          price = matches[4].to_f
          type = categorize(name)

          @items << ReceiptItem.new(name, type, quantity, price, imported)
        else
          $stderr.puts "Warning: line #{index + 1} of #{@purchase_file_path} could not be parsed."
        end
      end

      @items
    end

    private

    # TODO: Consider moving this into its own Categorizer class?
    def categorize(name)
      ITEM_CATEGORIES.each do |category, examples|
        return category if examples.any? { |example| name.match?(example) }
      end

      DEFAULT_CATEGORY
    end
  end
end
