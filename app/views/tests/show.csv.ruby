require 'csv'

testcases = @test.testcases

# Examine the maximum heading level
max_level = 0
testcases.each do |c|
  if c.type == :heading
    max_level = c.heading_level if c.heading_level > max_level  
  end
end
headings = Array.new(max_level)

# Header
header = Array.new(max_level, "-")
header << I18n.t("tests.csv.case") << I18n.t("tests.csv.result") << I18n.t("tests.csv.note")

# Generate csv
CSV.generate(headers: header, write_headers: true, force_quotes: true) do |csv|
# CSV.generate do |csv|
  testcases.each do |c|
    case c.type
      when :heading
        # Clear unnecessary column
        length = max_level - c.heading_level
        headings[c.heading_level, length] = Array.new(length, "")

        # Set value to column
        headings[c.heading_level - 1] = c.body
      when :testcase
        row = Array.new(headings)
        row << c.body << c.result << c.note
        csv << row
    end
  end
end