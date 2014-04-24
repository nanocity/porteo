require 'simplecov'
require 'simplecov-rcov-text'

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovTextFormatter.new.format(result)
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.start

require 'porteo'

EMITTER_PATH     = 'features/support/emitter.yml'
TEMPLATES_PATH   = 'features/support/templates/'
ATTACHMENTS_PATH = 'features/support/attachments/'
