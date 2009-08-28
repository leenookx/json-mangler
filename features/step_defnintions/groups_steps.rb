Given /^I already have a valid JSON mock stream containing groups$/ do
  @response = File.open('features/mocks/grouped.json', 'r') {|f| f.readlines.to_s}
end

When /^I group the contents of the mangling object$/ do
  @json_mangler.group
end

Then /^the JSON mangler remains valid$/ do
  assert_equal(@json_mangler, true)
end

Then /^the JSON stream is grouped correctly$/ do
  pending
end

Given /^I already have a valid JSON mock stream containing no groups$/ do
  @response = File.open('features/mocks/non_grouped.json', 'r') {|f| f.readlines.to_s}
end

Then /^the JSON stream remains the same as at the start$/ do
  pending
end

