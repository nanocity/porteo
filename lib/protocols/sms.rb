module Porteo
  module Protocol
    # Implementation of SMS protocol to be used in Porteo system.
    # It only define specific behavior for this protocol.
    class Sms < Base

      # Check for the required fields to exists.
      # @return [nil]
      # @raise [ArgumentError] if message cannot be sent.
      def check_message_sections
        raise ArgumentError, "Protocol Error. There are not text section" if @message_sections[:text] == nil
        # The sms must match GSM alphabet, double counting these chars
        # [ , ], <FF>, ^, \, {, }, ~, | and €
        count = 0

        @message_sections[:text].each_char do | c |
          count = count + 1 if c =~ /[\[\]\^\\\{\}\~\|€]/
          count = count + 1
        end

        raise ArgumentError, "Protocol Error. The message is too long" if count > 160
        raise ArgumentError, "Protocol Error. The phone number is invalid" unless @message_sections[:phone] =~ /^\d{9}$/
        raise ArgumentError, "Protocol Error. The country phone code is invalid" unless @message_sections[:code] =~ /^\d{2,4}$/
        raise ArgumentError, "Protocol Error. The sender is invalid" unless @message_sections[:sender] =~ /^[A-Za-z0-9]{1,11}$/
      end

      # Implementates the parent method to ensure that sms receptor is
      # the one set at receiver instance variable not the :phone template tag
      # @return [nil]
      def override_tags
        # In sms protocol, the receiver instance variable has precedence over
        # :phone tag in template
        @message_sections[:phone] = @receiver unless @receiver == nil
      end
    end
  end
end
