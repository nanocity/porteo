require 'gateways/base'
require 'gateways/twitter'
require 'gateways/pony'
require 'gateways/mensario'

require 'protocols/base'
require 'protocols/mail'
require 'protocols/sms'
require 'protocols/twitter'

require 'message/message'

require 'erb'
require 'twitter'
require 'mensario'
require 'pony'
require 'yaml'

# Porteo is an integrated message sending service.
# It allows you to send messages by various protocols (sms, email, twitter)
# using differents gateways (mensario, pony, twitter API). You can also
# integrate new protocols and gateways for your favorite messenger
# service.
module Porteo
  # Default configuration path
  CONFIG_ROOT = "./config/"
  # Default templates path
  TEMPLATES_ROOT = "./config/templates/"
  # Default locales path
  LOCALES_ROOT = "./config/locales/"
end
