Given /^I already have a valid JSON mock stream$/ do
  @response = File.open('features/mocks/valid.json','r') {|f| f.readlines.to_s}
end

When /^I try and create a mangler object$/ do
  @json_mangler = JSONMangler.new( @response )
end

Then /^the resultant object is valid$/ do
  assert_equal(@json_mangler.valid, true)
end

Then /^I should get an invalid JSON mangler object$/ do
  assert_equal(@json_mangler.valid, false)
end

Given /^I already have an empty JSON mock stream$/ do
  @response = File.open('features/mocks/empty.json','r') {|f| f.readlines.to_s}
end

Then /^the output equals the input JSON mock stream$/ do
  assert_not_equal("nil", @json_mangler.to_json)
end

