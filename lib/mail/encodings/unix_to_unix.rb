# encoding: utf-8
require 'mail/encodings/transfer_encoding'

module Mail
  module Encodings
    class UnixToUnix < TransferEncoding
      NAME = 'x-uuencode'

      PRIORITY = 10

      def self.decode(str)
        str.sub(/\Abegin \d+ [^\n]*\n/, '').unpack('u').first
      end

      def self.encode(str)
        [str].pack("u")
      end

      # uuencoded is approx. 135% bigger than original according to man page
      def self.cost(str)
        1.35
      end

      Encodings.register(NAME, self)
    end
  end
end
