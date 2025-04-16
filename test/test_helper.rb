require "minitest/autorun"
require "receipt_printer"

def fixture_file(file_name)
  File.join(File.expand_path(__dir__), "fixtures", file_name)
end
