module ReceiptPrinter
  class ReceiptItem
    TAX_EXEMPT_TYPES = %w[book food medical]
    SALES_TAX_RATE = 0.10
    IMPORT_DUTY_RATE = 0.05

    attr_accessor :name, :type, :quantity, :price, :imported

    def initialize(name, type, quantity, price, imported)
      @name = name
      @type = type
      @quantity = quantity
      @price = price
      @imported = imported
    end

    def basic_sales_tax
      return 0.0 if TAX_EXEMPT_TYPES.any?(@type)

      @price * @quantity * SALES_TAX_RATE
    end

    def import_duty
      return 0.0 unless @imported

      @price * @quantity * IMPORT_DUTY_RATE
    end

    def sales_tax
      ((basic_sales_tax + import_duty) * 20.0).round / 20.0
    end

    def to_s
      "#{@quantity} #{@imported ? "imported " : ""}#{@name}: #{sprintf("%.2f", total)}"
    end

    def total
      (@price * @quantity + sales_tax).round(2)
    end
  end
end
