require 'spec_helper'

describe Porteo::Gateway::Mensario do
  let( :sms_config ) do
    {
      license: 'LICENSE',
      username: 'USERNAME',
      password: 'PASSWORD'
    }
  end

  let( :sms_data ) do
    {
      text: 'Hello World',
      code: '34',
      phone: '666112233',
      sender: '666998877',
      timezone: nil,
      date: nil
    }
  end

  # Check that pony respond to all methods
  it "should respond to all methods that are in the parent class" do
    Porteo::Gateway::Mensario.new({}).should respond_to( :send_message )
  end

  it "should send a sms through Mensario" do
    mensario_conf = sms_data.merge( sms_config )

    ::Mensario.stub( :send_message ).with( mensario_conf ).and_return( true )
    expect( ::Mensario ).to receive( :send_message ).with( sms_data )

    Porteo::Gateway::Mensario.new( sms_config ).send_message( sms_data )
  end
end
