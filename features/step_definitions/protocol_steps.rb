Given /^I want to send an email$/ do
  config = YAML.load_file( EMITTER_PATH )[:mail][:default]
  @protocol = Porteo::Protocol::Mail.new( config )
end

Given /^I use the template "([^"]*)"$/ do |template_file|
  @requires, @template = YAML.load_file( TEMPLATES_PATH + template_file ).values
end

Given /^I fill template variable "(.*?)" with value "(.*?)"$/ do |key, value|
  @params = @params || {}
  @params[key.to_sym] = value
end

Given /^I dont fill template variable "(.*?)"$/ do |key|
  @params.delete( key.to_sym )
end

When /^I attach the template to the message$/ do
  @protocol.set_template( @template, @requires )
  @protocol.set_template_params( @params )
end

Then /^the message should contain text "(.*?)"$/ do |text|
  @protocol.message.should match( /#{text}/ )
end

Then /^the message should raise an exception about required parameters$/ do
  expect{
    @protocol.message
  }.to raise_exception ArgumentError
end

Then /^email protocol should delegate the sending to the gateway$/ do
  Pony.stub( :mail ).and_return( true )
  Porteo::Gateway::Pony.any_instance.should_receive( :init_send )

  @protocol.receiver = "marge@nosolosoftware.biz"
  @protocol.send_message
end
