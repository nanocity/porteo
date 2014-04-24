require 'spec_helper'

describe Porteo::Gateway::Pony do
  let( :email_config ) do
    {
      via: :smtp,
      via_options: {
        address: 'mail.domain.com',
        port: 465,
        user_name: 'USER',
        password: 'PASSWORD',
        enable_starttls_auto: false,
        authentication: :plain,
        domain: 'DOMAIN'
      }
    }
  end

  let( :email_data ) do
    {
      to:      'homer@nosolosoftware.biz',
      from:    'marge@nosolosoftware.biz',
      body:    'Yuhuuuu!',
      subject: 'Test!'
    }
  end

  # Check that pony respond to all methods
  it "should respond to all methods that are in the parent class" do
    Porteo::Gateway::Pony.new({}).should respond_to( :send_message )
  end

  it "should send a mail through Pony" do
    pony_conf = email_data.merge( email_config )

    Pony.stub( :mail ).with( pony_conf ).and_return( true )
    expect( Pony ).to receive( :mail ).with( pony_conf )

    Porteo::Gateway::Pony.new( email_config ).send_message( email_data )
  end
end

