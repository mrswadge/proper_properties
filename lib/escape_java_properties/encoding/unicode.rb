module EscapeJavaProperties
  module Encoding
    # Module to encode and decode unicode chars
    # @see EscapeJavaProperties::Encoding
    module Unicode
      
      # Marker for encoded unicode chars
      # @return [Regexp]
      UNICODE_MARKER  = /\\[uU]([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})/

      # Escape char for unicode chars
      # @return [String]
      UNICODE_ESCAPE = "\\u"

      # Decodes all unicode chars from escape sequences in place
      # @param text [String]
      # @return [String] The encoded text for chaining
      def self.decode!(text)
        text.gsub!(UNICODE_MARKER) do
          unicode($1.hex)
        end
        text
      end

      # Decodes all unicode chars into escape sequences in place
      # @param text [String]
      # @return [String] The decoded text for chaining
      def self.encode!(text)
        buffer = StringIO.new
        text.each_char do |char|
          if char.ascii_only?
            buffer << char
          else
            buffer << UNICODE_ESCAPE
            buffer << hex(char.codepoints.first)
          end
        end
        text.replace buffer.string
        text
      end

      private

      def self.unicode(code)
        [code].pack("U")
      end

      def self.hex(codepoint)
        # For BMP codepoints produce a 4-digit hex (\uXXXX).
        # For supplementary codepoints produce a surrogate pair
        # encoded as "XXXX\\uYYYY" so callers that prepend
        # the "\\u" marker produce "\\uXXXX\\uYYYY".
        if codepoint <= 0xFFFF
          format('%04x', codepoint)
        else
          cp = codepoint - 0x10000
          high = 0xD800 + (cp >> 10)
          low  = 0xDC00 + (cp & 0x3FF)
          "#{format('%04x', high)}\\u#{format('%04x', low)}"
        end
      end

    end
  end
end
