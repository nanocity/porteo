# encoding: utf-8
require 'rubygems'
require 'bundler'

require 'metric_fu'

begin
  Bundler.setup( :default, :development )
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'yard'
YARD::Rake::YardocTask.new( :doc ) do |t|
  t.files = ['./lib/porteo.rb', './lib/message/*', './lib/gateways/*', './lib/protocols/*']
  t.options = ['-m', 'markdown', '-r' , 'README.markdown']
end

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new( :features ) do |t|
  t.cucumber_opts = ["./features --exclude ./features/message/send_a_message_by_sms.feature"]
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new( :spec ) do |t|
  t.rspec_opts = ["--format doc", "--color"]
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20
  gem.name = 'porteo'
  gem.homepage = 'http://github.com/nosolosoftware/porteo'
  gem.license = 'MIT'
  gem.summary = %Q{A Ruby gem for sending all kind of messages like emails, sms and twitts}
  gem.description = %Q{This gem allows you to send messages using Email, Sms or Twitter. It can be easily extend to send some other kind of messages or use another gateways (Porteo, Mensario and Twitter)}
  gem.email = ['rgarcia@nosolosoftware.biz', 'lciudad@nosolosoftware.biz']
  gem.authors = ['Rafael Garcia', 'Luis Ciudad']
  # dependencies defined in Gemfile

  # Files not included
  ['Gemfile', 'Rakefile', 'Gemfile.lock', 'spec/**/*'].each do |d|
    gem.files.exclude d
  end

end
Jeweler::RubygemsDotOrgTasks.new
