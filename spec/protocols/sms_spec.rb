require 'spec_helper'

describe Porteo::Protocol::Sms do

  describe "Check required fields" do

    let( :sms_config ){ YAML.load_file( EMITTER_PATH )[:sms][:default] }
    let( :template ){   YAML.load_file( TEMPLATES_PATH + 'message.sms' ) }

    before(:each) do
      @protocol = Porteo::Protocol::Sms.new( sms_config )
      @template = template
      @protocol.set_template_params( :phone => "666112233", :code => "34" )
    end

    context "message body is longer than 160" do
      after do
        expect{ @protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. The message is too long/
      end

      it "should raise an exception" do
        @template[:template][:text] = "a"*161
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end

      it "should double count extended gsm symbols" do
        @template[:template][:text] = "a" * 143 + '€[]{}^\~|'
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end
    end

    context "country code is not correct" do
      after do
        expect{ @protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. The country phone code is invalid/
      end

      it "should raise an exception if country code is 1" do
        @template[:template][:code] = "1"
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end

      it "should raise and exception if country code is 12345" do
        @template[:template][:code] = "12345"
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end
    end

    context "destination phone number is not correct" do
      after do
        expect{ @protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. The phone number is invalid/
      end

      it "should raise an exception if phone number is not correct" do
        @template[:template][:phone] = "12345678"
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end
    end

    context "sender is not correct" do
      after do
        expect{ @protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. The sender is invalid/
      end

      it "should raise an exception if sender is not correct" do
        @template[:template][:sender] = "John Doe"
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end

      it "should raise an exception if sender is too long" do
        @template[:template][:sender] = "SomeRareCompoundName!"
        @protocol.set_template( @template[:template].to_s, @template[:requires] )
      end
    end
  end
end
