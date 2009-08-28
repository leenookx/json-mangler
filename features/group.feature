Feature: Grouping
  In order to test that the JSON stream can be grouped into common tags
  As a developer
  I want to create new mangling objects
  And then group the data held within them

  Scenario: After grouping the mangling object remains valid
    Given I already have a valid JSON mock stream containing groups
    When I group the contents of the mangling object
    Then the JSON mangler remains valid

  Scenario: After grouping the correct groups are formed
    Given I already have a valid JSON mock stream containing groups
    When I group the contents of the mangling object
    Then the JSON stream is grouped correctly

  Scenario: Trying a group a non-repeating JSON stream makes no difference
    Given I already have a valid JSON mock stream containing no groups
    When I group the contents of the mangling object
    Then the JSON stream remains the same as at the start

