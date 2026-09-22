require 'helper'
require 'tempfile'

describe EscapeJavaProperties do
  subject{ EscapeJavaProperties }

  it "parses from string to symbol hash" do
    subject.parse("item1=item1").must_equal({:item1 => "item1"})
  end

  it "generates from hash" do
    subject.generate({:item1 => "item1"}).must_equal("item1=item1")
    subject.generate({"item2" => "item2"}).must_equal("item2=item2")
  end

  it "loads from file and create a hash" do
    with_temp_file do |file|
      file << "item1=item1"
      file.flush

      subject.load(file.path).must_equal({:item1 => "item1"})

    end
  end

  it "loads from file and allows symbol/string access" do
    with_temp_file do |file|
      file << "item1=item1"
      file.flush

      properties = subject.load(file.path)
      properties[:item1].must_equal("item1")
      properties['item1'].must_equal("item1")
    end
  end

  it "loads from file and allows manipulation" do
    with_temp_file do |file|
      file << "item1=item1\n"
      file << "item2=item2\n"
      file << "item3=item3\n"
      file << "item4=item4"
      file.flush

      properties = subject.load(file.path)

      properties.values_at(:item1, "item2", 'item3').must_equal(["item1", "item2", "item3"])


      properties[:item2].must_equal("item2")
      properties.delete(:item2).must_equal("item2")
      proc{ properties[:item2] }.must_raise(KeyError)

      properties['item3'].must_equal("item3")
      properties.delete('item3').must_equal("item3")
      proc{ properties['item3'] }.must_raise(KeyError)

      properties.key?(:item4).must_equal(true)
      properties.key?('item4').must_equal(true)

      properties.key?(:item5).must_equal(false)
      properties.key?('item5').must_equal(false)
    end
  end

  it "writes to file" do
    with_temp_file do |file|      
      subject.write({:item1 => "item1", "item2" => "item2"}, file.path)

      file.rewind
      file.read.must_equal "item1=item1\nitem2=item2"
    end
  end

  private

  def with_temp_file(&block)
    file = Tempfile.new("proper_properties")
    block.call(file)
  ensure
    file.close
    file.unlink
  end

end
