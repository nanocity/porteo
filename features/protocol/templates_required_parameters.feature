Feature: Check the template requires
  As a user
  I want to be report about required parameters
  in order to be able to send valid messages

  Scenario: All required params aren't present
    Given I want to send an email
    And I use the template "valid.mail"
    And I fill template variable "name" with value "Jhon"
    And I dont fill template variable "surname"
    When I attach the template to the message
    Then the message should raise an exception about required parameters
