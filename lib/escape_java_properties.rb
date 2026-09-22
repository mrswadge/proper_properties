require 'escape_java_properties/version'
require 'escape_java_properties/properties'
require 'escape_java_properties/encoding'
require 'escape_java_properties/parsing'
require 'escape_java_properties/generating'

# A module to read and write Escape java properties files
module EscapeJavaProperties

  # Parses the content of a escape javaproperties file
  # @see Parsing::Parser
  # @param text [String]
  # @return [Properties]
  def self.parse(text)
    Parsing::Parser.parse(text)
  end

  # Generates the content of a escape java properties file
  # @see Generating::Generator
  # @param hash [Hash] 
  # @param options [Hash] options for the generator
  # @return [String]
  def self.generate(hash, options = {})
    Generating::Generator.generate(hash, options)
  end

  # Loads and parses a escape java properties file
  # @see Parsing::Parser
  # @param path [String]
  # @param encoding [String]
  # @param allow_invalid_byte_sequence [Boolean]
  # @return [Properties]
  def self.load(path, encoding = 'UTF-8', allow_invalid_byte_sequence = true)
      # Read as binary and then transcode to the desired encoding. Ruby 4 changed
      # String#encode signature; use `encode` with keyword options when available.
      content = File.binread(path)
      if allow_invalid_byte_sequence
        parse(content.encode(encoding, invalid: :replace, undef: :replace))
      else
        parse(content.encode(encoding))
      end
  end

  # Generates a escape java properties file
  # @see Generating::Generator
  # @param hash [Hash]
  # @param path [String]
  # @param options [Hash] options for the generator
  def self.write(hash, path, options = {})
    File.write(path, generate(hash, options))
  end

end
