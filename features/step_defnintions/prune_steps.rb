When /^prune the '(.*)' branch$/ do |branch|
  @json_mangler.prune( branch )
end

Then /^the '(.*)' branch is removed$/ do |branch|
  response = JSON.parse( @json_mangler.to_json )

  assert_equal(response[branch], nil)
end

