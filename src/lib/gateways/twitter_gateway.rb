require './src/lib/gateways/gateway'
require 'twitter'

module Porteo

  class Twitter_gateway < Gateway

    connection_argument :consumer_key, 
                        :consumer_secret, 
                        :oauth_token, 
                        :oauth_token_secret

    def send_message( msg )
      Twitter.configure do |config|
        config.consumer_key = @config[:consumer_key]
        config.consumer_secret = @config[:consumer_secret]
        config.oauth_token = @config[:oauth_token]
        config.oauth_token_secret = @config[:oauth_token_secret]
      end

     Twitter.update( msg[:body] ) 
    end 
  end

end

