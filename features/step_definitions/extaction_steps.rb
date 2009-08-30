Given /^I already have a JSON stream$/ do
    @extraction_input = File.open('features/mocks/extraction.json', 'r') {|f| f.readlines.to_s}
end

When /^I try and extract a tag '(.*)' which doesn't exist$/ do |tag|
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, tag) 
end

Then /^the resultant JSON is empty$/ do
   extraction_comparison = File.open('features/test_comparisons/empty_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end

When /^I try and extract the authors name$/ do
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, "author")
end

Then /^the resultant JSON contains the author details$/ do
   extraction_comparison = File.open('features/test_comparisons/author_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end
