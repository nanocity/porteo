Feature: Set a template to be filled with parameters
  As a user
  I want to have message templates
  So I can use them to create a lot of message without effort

  Scenario: Setting up a template for a message in a custom location
    Given a emitter "nosolosoftware"
    And a protocol "mail"
    And a profile "admin"
    And a configure files location "examples_helpers/config/"
    And a template files location "examples_helpers/config/templates/"
    And a new message by emitter, protocol, profile, custom location and custom template location
    When I set template to "dummy"
    Then template should be set to a "dummy" 
    
