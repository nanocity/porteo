require 'spec_helper'

describe Porteo::Protocol::Base do

  describe "Check for a non generic protocol" do
    let( :config ){   YAML.load_file( EMITTER_PATH )[:mail][:default] }
    let( :template ){ YAML.load_file( TEMPLATES_PATH + 'message.mail' ) }

    it "should raise an exception if gateway is not defined" do
      protocol = Porteo::Protocol::Base.new( config.merge( gateway: :undefined ) )
      template[:template][:to] = "homer@simpson.com"

      protocol.set_template( template[:template].to_s, template[:requires] )
      protocol.set_template_params( :name => 'Marge', :loops => 5 )

      protocol.stub( :check_message_sections )
      expect{ protocol.send_message }.to raise_exception( ArgumentError, /Protocol Error. Undefined gateway/ )
    end

    it "should raise an if base protocol is used without subclassing" do
      protocol = Porteo::Protocol::Base.new( config.merge( gateway: :undefined ) )
      template[:template][:to] = "homer@simpson.com"

      protocol.set_template( template[:template].to_s, template[:requires] )
      protocol.set_template_params( :name => 'Marge', :loops => 5 )

      expect{ protocol.send_message }.to raise_exception( Exception, /Protocol Error. This method has to be overwritten/ )
    end
  end
end
