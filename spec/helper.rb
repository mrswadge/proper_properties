require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

require 'minitest/autorun'
require 'escape_java_properties'

class Minitest::Spec

  def fixture(*segments)
    File.read(File.join(File.dirname(__FILE__), "fixtures", *segments))
  end

end

# Provide simple expectation methods for older spec-style tests when running
# under newer Minitest/Ruby combinations.
TEST_ASSERTIONS = Object.new
TEST_ASSERTIONS.extend(Minitest::Assertions)
def TEST_ASSERTIONS.assertions
  @assertions ||= 0
end
def TEST_ASSERTIONS.assertions=(n)
  @assertions = n
end

class Object
  def must_equal(expected)
    TEST_ASSERTIONS.assert_equal expected, self
  end

  def wont_be_nil
    TEST_ASSERTIONS.refute_nil self
  end
end

class Proc
  def must_raise(*klasses)
    TEST_ASSERTIONS.assert_raises(*klasses) { call }
  end
end
