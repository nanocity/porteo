require 'spec_helper'

describe Porteo::Message do
  let( :message ){ Porteo::Message.new }

  context "when all configuration is correct" do
    before do
      message.configure do |m|
        m.emitter =       'empty'
        m.config_path =   File.dirname( EMITTER_PATH )+ '/'
        m.template_path = TEMPLATES_PATH
      end
    end

    it "should expand the message template" do
      Pony.stub( :mail ).and_return( true )

      message.configure do |m|
        m.protocol = 'mail'
        m.template = 'message'
      end

      message.set_template_params( :name => 'Bob', :loops => 3 )
      message.send_message
      message.show_message.should match( /3 times: BobBobBob/ )
    end

    context "when template parameters are set" do
      it "should set template parameters through methods" do
        Pony.stub( :mail ).and_return( true )

        message.configure do |m|
          m.protocol = 'mail'
          m.template = 'message'
        end

        message.name = 'Bob'
        message.loops = 3

        message.send_message
        message.show_message.should match( /3 times: BobBobBob/ )
      end

      it "should raise an exception if a method does not exist" do
        Pony.stub( :mail ).and_return( true )

        message.configure do |m|
          m.protocol = 'mail'
          m.template = 'message'
        end

        message.name = 'Bob'
        message.loops = 3

        expect{ message.another_parameter( 'Fail' ) }.to raise_exception( NoMethodError )
      end
    end

    context "while sending an email" do
      before do
        Pony.stub( :mail ).and_return( true )
        expect( Pony ).to receive( :mail )
      end

      it "should contact with Pony interface" do
        message.configure do |m|
          m.protocol = 'mail'
          m.template = 'message'
        end

        message.set_template_params( :name => 'Bob', :loops => 3 )
        message.send_message
      end
    end

    context "while sending a sms" do
      before do
        ::Mensario.stub( :send_message ).and_return( true )
        expect( ::Mensario ).to receive( :send_message )
      end

      it "should contact with Mensario interface" do
        message.configure do |m|
          m.protocol = 'sms'
          m.template = 'message'
          m.code = '34'
          m.phone = '666112233'
        end

        message.send_message
      end
    end

    context "while sending a twitt" do
      before do
       Twitter::REST::Client.any_instance.stub( :update ).and_return( true )
       Twitter::REST::Client.any_instance.should_receive( :update )
      end

      it "should contact with Twitter interface" do
        message.configure do |m|
          m.protocol = 'twitter'
          m.template = 'message'
        end

        message.set_template_params( :message => 'Hello World!' )
        message.send_message
      end
    end
  end

  context "when emitter file is missing" do
    before do
      message.configure do |m|
        m.emitter =       'non-existing-file'
        m.config_path =   File.dirname( EMITTER_PATH )+ '/'
        m.template_path = TEMPLATES_PATH
      end
    end

    it "should raise and exception" do
      message.configure do |m|
        m.protocol = 'mail'
        m.template = 'message'
      end

      message.set_template_params( :name => 'Bob', :loops => 3 )
      expect{ message.send_message }.to raise_exception( ArgumentError, /Message Error. Invalid emitter file/ )
    end
  end

  context "when protocol is not defined" do
    before do
      message.configure do |m|
        m.emitter =       'empty'
        m.config_path =   File.dirname( EMITTER_PATH )+ '/'
        m.template_path = TEMPLATES_PATH
      end
    end

    it "should raise and exception" do
      message.configure do |m|
        m.protocol = 'xmpp'
        m.template = 'message'
      end

      YAML.stub( :load_file ).with( 'spec/support/empty.emitter' ).and_return( { xmpp: { default: {} } } )
      YAML.stub( :load_file ).with( 'spec/support/templates/message.xmpp' ).and_return( { requires: [], content: '' } )

      message.set_template_params( :name => 'Bob', :loops => 3 )
      expect{ message.send_message }.to raise_exception( ArgumentError, /Message Error. Undefined protocol/ )
    end
  end

  context "when template does not exist" do
    before do
      message.configure do |m|
        m.emitter =       'empty'
        m.config_path =   File.dirname( EMITTER_PATH )+ '/'
        m.template_path = TEMPLATES_PATH
      end
    end

    it "should raise and exception" do
      message.configure do |m|
        m.protocol = 'xmpp'
        m.template = 'message'
      end

      YAML.stub( :load_file ).and_call_original
      YAML.stub( :load_file ).with( 'spec/support/empty.emitter' ).and_return( { xmpp: { default: {} } } )

      expect{ message.send_message }.to raise_exception( ArgumentError, /Message Error. Invalid template file/ )
    end
  end
end
