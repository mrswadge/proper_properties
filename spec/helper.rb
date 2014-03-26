require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start
Coveralls.wear!

require 'minitest/autorun'
require 'proper_properties'

class MiniTest::Spec

  def fixture(*segments)
    File.read(File.join(File.dirname(__FILE__), "fixtures", *segments))
  end

end
