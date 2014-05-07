require 'spec_helper'

describe Porteo::Message do
  context "when all configuration is correct" do
    before do
      @message = Porteo::Message.new

      @message.configure do |m|
        m.emitter =       'empty'
        m.config_path =   File.dirname( EMITTER_PATH )+ '/'
        m.template_path = TEMPLATES_PATH
      end
    end

    context "while sending an email" do
      before do
        Pony.stub( :mail ).and_return( true )
        expect( Pony ).to receive( :mail )
      end

      it "should contact with Pony interface" do
        @message.configure do |m|
          m.protocol = 'mail'
          m.template = 'message'
        end

        @message.set_template_params( :name => 'Bob', :loops => 3 )
        @message.send_message
      end
    end

    context "while sending a sms" do
      before do
        ::Mensario.stub( :send_message ).and_return( true )
        expect( ::Mensario ).to receive( :send_message )
      end

      it "should contact with Mensario interface" do
        @message.configure do |m|
          m.protocol = 'sms'
          m.template = 'message'
          m.code = '34'
          m.phone = '666112233'
        end

        @message.send_message
      end
    end

    context "while sending a twitt" do
      before do
       Twitter::REST::Client.any_instance.stub( :update ).and_return( true )
       Twitter::REST::Client.any_instance.should_receive( :update )
      end

      it "should contact with Twitter interface" do
        @message.configure do |m|
          m.protocol = 'twitter'
          m.template = 'message'
        end

        @message.set_template_params( :message => 'Hello World!' )
        @message.send_message
      end
    end
  end
end
