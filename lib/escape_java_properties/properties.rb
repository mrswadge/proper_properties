module EscapeJavaProperties
  # Simple representation of a properties file content
  # by an extension of a Hash object a la ActiveSupport::HashWithIndifferentAccess, with underlying symbol keys
  class Properties < Hash

    # Assigns a new value to the hash:
    #
    #   hash = EscapeJavaProperties::Properties.new
    #   hash[:key] = 'value'
    #
    # This value can be later fetched using either +:key+ or +'key'+.
    def []=(key, value)
      super(convert_key(key), value)
    end

    # Checks the hash for a key matching the argument passed in:
    #
    #   hash = EscapeJavaProperties::Properties.new
    #   hash['key'] = 'value'
    #   hash.key?(:key)  # => true
    #   hash.key?('key') # => true
    def key?(key)
      super(convert_key(key))
    end

    # Same as <tt>Hash#fetch</tt> where the key passed as argument can be
    # either a string or a symbol:
    #
    #   counters = EscapeJavaProperties::Properties.new
    #   counters[:foo] = 1
    #
    #   counters.fetch('foo')          # => 1
    #   counters.fetch(:bar, 0)        # => 0
    #   counters.fetch(:bar) {|key| 0} # => 0
    #   counters.fetch(:zoo)           # => KeyError: key not found: "zoo"
    def fetch(key, *extras)
      super(convert_key(key), *extras)
    end

    # Returns an array of the values at the specified indices:
    #
    #   hash = EscapeJavaProperties::Properties.new
    #   hash[:a] = 'x'
    #   hash[:b] = 'y'
    #   hash.values_at('a', 'b') # => ["x", "y"]
    def values_at(*indices)
      indices.collect {|key| self[convert_key(key)]}
    end

    # Removes the specified key from the hash.
    def delete(key)
      super(convert_key(key))
    end

    def [](key)
      self.fetch(key)
    end

  	protected
      def convert_key(key)
        key.kind_of?(String) ? key.to_sym : key
    end
  end
end
