Given /^a new message$/ do
  @message = Porteo::Message.new
end

When /^I set the message template to "([^"]*)"$/ do |template|
  @message.template = template
end

