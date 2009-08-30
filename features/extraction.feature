Feature: Creation
  In order to test that we can extract data from the JSON stream
  As a developer
  I want to try and extract some tags

  Scenario: Make sure we can't remove any tags unless they exist
    Given I already have a JSON stream
    When I try and extract a tag 'non-existant' which doesn't exist
    Then the resultant JSON is empty

  Scenario: Ensure we can extract simple top-level tags
    Given I already have a JSON stream
    When I try and extract the authors name 
    Then the resultant JSON contains the author details

  Scenario: Ensure we can extract simple data forms
    Given I already have a JSON stream
    When I try and extract any tags where the publishing date was 1999
    Then the resultant JSON contains the publishing date

  Scenario: Ensure we can extract data from complicated JSON data
    Given I already have a complicated JSON stream
    When I try and extract any tags where the publishing date was 1999
    Then the resultant JSON contains the publishing date

  Scenario: Ensure that we can extract data from JSON arrays
    Given I already have a JSON stream
    When I try and extract data from the keyword array
    Then the resultant JSON data contains the array

