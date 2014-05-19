module Porteo
  module Protocol
    # Implementation of Twitter protocol to be used in Porteo system.
    # It only define specific behavior for this protocol.
    class Twitter < Base

      # Check for the required fields to exists.
      # @return [nil]
      # @raise [ArgumentError] if message cannot be sent.
      def check_message_sections
        raise ArgumentError, "Protocol Error. There is no body section" if @message_sections[:body] == nil
        # the twitt must be shorter than 140 chars.
        raise ArgumentError, "Protocol Error. The message is too long" if @message_sections[:body].length > 140
      end
    end
  end
end
