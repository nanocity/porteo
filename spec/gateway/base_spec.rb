require 'spec_helper'

describe Porteo::Gateway::Base do
  it "should raise an error if it is used without subclassing" do
    expect{ Porteo::Gateway::Base.new({}).send_message([]) }.to raise_exception( Exception, /Gateway Error/ )
  end

  it "should return an empty array as configuration parameters" do
    gw = Porteo::Gateway::Base.new( {} )
    gw.connection_arguments.should == []
  end
end
