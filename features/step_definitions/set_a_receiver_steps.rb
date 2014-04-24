When /^I set "([^"]*)" as receiver of that message$/ do |receiver|
  @message.receiver = receiver
end

Then /^message should contain the "([^"]*)" receiver$/ do |receiver|
  @message.receiver.should == receiver
end

