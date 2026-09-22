[properties_documentation]: http://docs.oracle.com/javase/6/docs/api/java/util/Properties.html#load(java.io.Reader)

# escape_java_properties

[![RubyGems](http://img.shields.io/gem/v/EscapeJavaProperties.svg)](http://rubygems.org/gems/EscapeJavaProperties)

A ruby library to read and write [Java properties files](http://en.wikipedia.org/wiki/.properties), which format is better described [in the Java documentation][properties_documentation].

## Installation

Install via Rubygems or Gemfile

```zsh
$ gem install EscapeJavaProperties
```

## Loading files

You can load a valid Java properties file from the file system using a path:

```ruby
properties = EscapeJavaProperties.load("path/to/my.properties")
properties[:foo] # => "bar"
properties['foo'] # => "bar"
```

If have already the content of the properties file at hand than parse the content as:

```ruby
properties = EscapeJavaProperties.load("foo=bar")
properties[:foo] # => "bar"
properties['foo'] # => "bar"
```

## Writing files

You can write any Hash-like structure (with symbol or string keys) as a properties file:

```ruby
hash = {:foo => "bar", "foobar" => "barfoo"}
EscapeJavaProperties.write(hash, "path/to/my.properties")
```

Or if you want to omit the file you can receive the content directly:

```ruby
hash = {:foo => "bar"}
EscapeJavaProperties.generate(hash)  # => "foo=bar"
```

## Encodings and special chars

Although ISO 8859-1 is assumed for Java properties files, they normally use UTF-8 encoding. This tool tries to convert them:

```
"ה" <=> "\u05d4"
```

The tool also escaped every '=', ' ' and ':' in the name part of a property line:

```ruby
EscapeJavaProperties.generate({"i : like=strange" => "bar"}) 
# => "i\ \:\ like\=strange=bar"
```

## Multi line and line breaks

In Java properties files there is distinction between natural lines and logical lines (than may span several lines by escaping the line terminator characters). 

Assume the following input:

```ini
my=This is a multi \
   line content with only \n one line break
```

The parses would read:

```ruby
{:my => "This is a multi line content which only \n one line break"}
```

In the opposite direction line breaks will be correctly escaped but the generator will never use multi line values.

## Contributing

1. [Fork it!](https://github.com/trace-devops/EscapeJavaProperties/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

- Trace DevOps
- Stuart Stephen (@mrswadge) : forked at [38b7f7b66b7a8d02c95c320f5921321a5f528b30](https://github.com/mrswadge/proper_properties/commit/38b7f7b66b7a8d02c95c320f5921321a5f528b30)
- Tnarik Innael (@tnarik) : forked at [f08b23a1341569f576eb4cf859f59350f58bd1c3](https://github.com/tnarik/proper_properties/commit/f08b23a1341569f576eb4cf859f59350f58bd1c3)
- Jonas Thiel (@jonasthiel) : [original project](https://github.com/jnbt/java-properties) upto [1f2c4b008d69d0eae1084b1adfdea814e2b29899](https://github.com/tnarik/proper_properties/commit/1f2c4b008d69d0eae1084b1adfdea814e2b29899)

## References

For a proper description about the properties file format have a look at the [Java Plattform documentation][properties_documentation].

## License

This gem is released under the MIT License. See the LICENSE.txt file for further details.
