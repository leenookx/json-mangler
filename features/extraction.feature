Feature: Creation
  In order to test that we can extract data from the JSON stream
  As a developer
  I want to try and extract some tags

  Scenario: Make sure we can't remove any tags unless they exist
    Given I already have a JSON stream
    When I try and extract some tags which don't exist
    Then the resultant JSON is empty

