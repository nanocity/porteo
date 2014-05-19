module Porteo
  module Gateway
    # Gateway to use Twitter service with Twitter gem.
    # In Porteo this class acts as a link between any twitter protocol
    # and Twitter gem.
    #
    # This class inherits from Gateway and just overwrite
    # the send_message method.
    class Twitter < Base

      connection_argument :consumer_key,
        :consumer_secret,
        :oauth_token,
        :oauth_token_secret

      # Send the twitt using Twitter gem.
      # @param [Hash] msg The message sections to send
      # @return [nil]
      def send_message( msg )
        client = ::Twitter::REST::Client.new do |config|
          config.consumer_key = @config[:consumer_key]
          config.consumer_secret = @config[:consumer_secret]
          config.access_token = @config[:oauth_token]
          config.access_token_secret = @config[:oauth_token_secret]
        end

        client.update( msg[:body] )
      end
    end
  end
end
