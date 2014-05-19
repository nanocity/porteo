require 'spec_helper'

describe Porteo::Protocol::Mail do

  describe "Check required fields" do
    let( :email_config ){ YAML.load_file( EMITTER_PATH )[:mail][:default] }
    let( :template ){     YAML.load_file( TEMPLATES_PATH + 'message.mail' ) }
    let( :protocol ){     Porteo::Protocol::Mail.new( email_config ) }

    before do
      Pony.stub( :mail ).and_return( true )
    end

    it "should raise an exception if :to tag is no correct" do
      template[:template][:to] = "www.homersimpson.com"

      protocol.set_template( template[:template].to_s, template[:requires] )
      protocol.set_template_params( :name => 'Marge', :loops => 5 )

      expect{ protocol.send_message }.to raise_exception( ArgumentError )
    end

    it "should not raise any exception if :to tag is correct" do
      template[:template][:to] = "homer@simpson.com"

      protocol.set_template( template[:template].to_s, template[:requires] )
      protocol.set_template_params( :name => 'Marge', :loops => 5 )

      expect{ protocol.send_message }.not_to raise_exception( Exception )
    end
  end

end
