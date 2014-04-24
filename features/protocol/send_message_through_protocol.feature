Feature: Send message
  As a user
  I want to send a message
  In order to comunicate something

  Scenario: Send email
    Given I want to send an email
    And I use the template "valid.mail"
    And I fill template variable "name" with value "Jhon"
    And I fill template variable "surname" with value "Doe"
    When I attach the template to the message
    Then email protocol should delegate the sending to the gateway
