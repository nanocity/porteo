require 'spec_helper'

describe Porteo::Protocol::Twitter do

  describe "Check required fields" do

    let( :twitter_config ){ YAML.load_file( EMITTER_PATH )[:twitter][:default] }
    let( :template ){       YAML.load_file( TEMPLATES_PATH + 'message.twitter' ) }
    let( :protocol ){       Porteo::Protocol::Twitter.new( twitter_config ) }

    context "message body is longer than 140" do
      after do
        expect{ protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. The message is too long/
      end

      it "should raise an exception" do
        template[:template][:body] = "a"*141
        protocol.set_template( template[:template].to_s, template[:requires] )
        protocol.set_template_params( :message => 'Hello World!' )
      end
    end

    context "message body is empty" do
      after do
        expect{ protocol.send_message }.to raise_exception ArgumentError, /Protocol Error. There is no body section/
      end

      it "should raise an exception" do
        template[:template][:body] = nil
        protocol.set_template( template[:template].to_s, template[:requires] )
        protocol.set_template_params( :message => 'Hello World!' )
      end
    end
  end
end
