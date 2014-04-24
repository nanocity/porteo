require 'spec_helper'

describe Porteo::Protocol::Sms do

  describe "Check required fields" do

    let( :sms_config ){ YAML.load_file( EMITTER_PATH )[:sms][:default] }
    let( :template ){   YAML.load_file( TEMPLATES_PATH + 'private.sms' ) }

    before(:each) do
      Twitter::REST::Client.any_instance.stub( :update ).and_return( true )

      @protocol = Porteo::Protocol::Sms.new( sms_config )
      @template = template
    end

    context "Validations" do
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

      context "sending data is incorrect" do
        after do
          expect{ @protocol.send_message }.to raise_exception ArgumentError
        end

        it "should raise an exception if country code is 1" do
          @template[:template][:code] = "1"
          @protocol.set_template( @template[:template].to_s, @template[:requires] )
        end

        it "should raise and exception if count is 12345" do
          @template[:template][:code] = "12345"
          @protocol.set_template( @template[:template].to_s, @template[:requires] )
        end

        it "should raise an exception if phone number is not correct" do
          @template[:template][:phone] = "12345678"
          @protocol.set_template( @template[:template].to_s, @template[:requires] )
        end

        it "should raise an exception if sender is not correct" do
          @template[:template][:sender] = "John Doe"
          @protocol.set_template( @template[:template].to_s, @template[:requires] )
        end

        it "should raise an exception if sender is too long" do
          @template[:template][:sender] = "FranciscoIbañezDeGuzman"
          @protocol.set_template( @template[:template].to_s, @template[:requires] )
        end
      end
    end
  end
end
