Feature: Set the template params
  As a user
  I want to set the template params
  In order to complete the template easily

  Scenario: Set the template params
    Given a new message
    When I set the message template to "small"
    And I send a message
    Then Complete template should be "Nombre: Paco, Repeticiones: 5"
