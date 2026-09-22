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
      parse(File.read(path).encode(encoding, 'binary', allow_invalid_byte_sequence ? {invalid: :replace, undef: :replace} : {} ))
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
