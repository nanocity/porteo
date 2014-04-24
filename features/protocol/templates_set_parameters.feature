Feature: Set template variable
  As a user
  I want to set the template variables
  In order to send different messages using the same template

  Scenario: Set a template variables
    Given I want to send an email
    And I use the template "valid.mail"
    And I fill template variable "name" with value "Jhon"
    And I fill template variable "surname" with value "Doe"
    When I attach the template to the message
    Then the message should contain text "Jhon"
    And the message should contain text "Doe"
