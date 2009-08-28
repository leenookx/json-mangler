Feature: Creation
  In order to test that the JSON stream can be pruned
  As a developer
  I want to prune some mangling objects

  Scenario: Prune branch from JSON stream Object
    Given I already have a valid JSON mock stream
    When I try and create a mangler object
      And prune the 'glossary' branch
    Then the 'glossary' branch is removed

