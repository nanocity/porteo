require 'spec_helper'

describe Porteo::Gateway::Twitter do
  let( :twitter_config ) do
    {
      consumer_key:        'CONSUMER_KEY',
      consumer_secret:     'CONSUMER_SECRET',
      access_token:        'OAUTH_TOKEN',
      access_token_secret: 'AOUTH_TOKEN_SECRET',
    }
  end

  # Check that respong to all methods
  it "should respond to all methods that are in the parent class" do
    Porteo::Gateway::Twitter.new( {} ).should respond_to( :send_message )
  end

  # Check that send a twitt
  it "should send a twitt through Twitter API" do
    message = { body: 'Im tweeting using Porteo' }

    Twitter::REST::Client.any_instance.stub( :update ).with( message[:body] ).and_return( true )
    Twitter::REST::Client.any_instance.should_receive( :update ).with( message[:body] )

    Porteo::Gateway::Twitter.new( twitter_config ).send_message( message )
  end
end
