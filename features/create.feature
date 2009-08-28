Feature: Creation
  In order to test that the JSON stream can be parsed
  As a developer
  I want to create new mangling objects

  Scenario: Create new JSON Mangler Object
    Given I already have a valid JSON mock stream
    When I try and create a mangler object
    Then the resultant object is valid

  Scenario: Try and create a JSON Mangler object from an empty JSON stream
    Given I already have an empty JSON mock stream
    When I try and create a mangler object
    Then I should get an invalid JSON mangler object

  Scenario: Create new JSON Mangler Object and check the output
    Given I already have a valid JSON mock stream
    When I try and create a mangler object
    Then the output equals the input JSON mock stream

