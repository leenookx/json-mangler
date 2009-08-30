Given /^I already have a JSON stream$/ do
    @extraction_input = File.open('features/mocks/extraction.json', 'r') {|f| f.readlines.to_s}
end

When /^I try and extract a tag '(.*)' which doesn't exist$/ do |tag|
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, "object", tag) 
end

Then /^the resultant JSON is empty$/ do
   extraction_comparison = File.open('features/test_comparisons/empty_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end

When /^I try and extract the authors name$/ do
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, "object", "author")
end

Then /^the resultant JSON contains the author details$/ do
   extraction_comparison = File.open('features/test_comparisons/author_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end

When /^I try and extract any tags where the publishing date was 1999$/ do
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, "data", "1999")
end

Then /^the resultant JSON contains the publishing date$/ do
   extraction_comparison = File.open('features/test_comparisons/published_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end

Given /^I already have a complicated JSON stream$/ do
    @extraction_input = File.open('features/mocks/extraction2.json', 'r') {|f| f.readlines.to_s}
end

When /^I try and extract data from the keyword array$/ do
    je = JSONExtractor.new
    @extraction_results = je.extract(@extraction_input, "data", "nonsense") 
end

Then /^the resultant JSON data contains the array$/ do
   extraction_comparison = File.open('features/test_comparisons/array_extraction.json', 'r') {|f| f.readlines.to_s}

   assert_equal(extraction_comparison, @extraction_results)
end

