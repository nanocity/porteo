module Porteo
  module Gateway
    # Gateway to use Mensario service
    # In Porteo this class acts as a link between SMS protocol
    # and Mensario gem
    #
    # This class inherits from Gateway and just overwrite
    # the send_message method
    class Mensario < Base

      connection_argument :license,
        :password,
        :username

      # Send the SMS using Mensario gem
      # @param [Hash] msg The message sections to send
      # @return [nil]
      def send_message( msg )
        ::Mensario.set_config do |m|
          m.license = @config[:license]
          m.username = @config[:username]
          m.password = @config[:password]
        end

        ::Mensario.send_message( {
          :text => msg[:text],
          :sender => msg[:sender],
          :code => msg[:code],
          :phone => msg[:phone],
          :timezone => msg[:timezone],
          :date => msg[:date]
        } )
      end
    end
  end
end
