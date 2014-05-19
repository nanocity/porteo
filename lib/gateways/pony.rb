module Porteo
  module Gateway
    # Gateway to use an email service with Pony gems.
    # In Porteo system, this class acts as a link between any email
    # protocol and Pony gem.
    #
    # This class inherits from Gateway class and just overwrite
    # the method send_message.
    class Pony < Base

      connection_argument :via_options => [:address, :port, :user_name, :password]

      # Options allowed for Pony API.
      # If you want to add any of these options
      # do it in message sections.
      PONY_OPTIONS = [
        :to,
        :cc,
        :bcc,
        :from,
        :body,
        :html_body,
        :subject,
        :charset,
        :attachments,
        :headers,
        :message_id,
        :sender
      ]

      # Via configuration options.
      # The sending method is configured with these options.
      VIA_OPTIONS = [
        :address,
        :port,
        :user_name,
        :password,
        :enable_starttls_auto,
        :authentication,
        :domain,
        :location,
        :argument
      ]

      # Send the message defined in parameter.
      # @param [Hash] message_sections Differents parts of message. Allowed keys
      #   are defined in PONY_OPTIONS.
      # @return [nil]
      def send_message( message_sections )
        # Create options hash to Pony
        pony_config = {}

        # Recover data from template
        # We look for each option defined before in the message content
        PONY_OPTIONS.each do |opt|
          pony_config[opt] = message_sections[opt] if message_sections[opt] != nil
        end

        # Recover data from send options
        # First we get the via used to send the message
        pony_config[:via] = @config[:via]

        # Then we look for the other configuration options
        pony_config[:via_options] = {}
        VIA_OPTIONS.each do |opt|
          pony_config[:via_options][opt] = @config[:via_options][opt] if @config[:via_options][opt] != nil
        end

        # Send the message
        ::Pony.mail( pony_config )
      end
    end
  end
end
