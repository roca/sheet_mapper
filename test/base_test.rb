require File.expand_path('../test_config.rb', __FILE__)

class TestBase < SheetMapper::Base
  columns :name, :age, :color

  def age
    self[:age] * 2
  end

  def name
    self[:name].upcase
  end
end

describe "Base" do
  setup do
    @data = ["Bob", 21, "Red"]
  end

  should "support columns class accessor" do
    assert_equal [:name, :age, :color], TestBase.columns
  end

  should "support pos instances accessor" do
    @test = TestBase.new(1, @data)
    assert_equal 1, @test.pos
  end

  context "for attributes method" do
    setup do
      @test = TestBase.new(1, @data)
    end

    should "return attribute hash" do
      assert_equal "BOB", @test.name
      assert_equal 42, @test.age
      assert_equal "Red", @test[:color]
    end
  end # attributes

  context "for accessing attribute" do
    setup do
      @test = TestBase.new(1, @data)
    end

    should "return value of attribute" do
      assert_equal "Bob", @test[:name]
    end
  end # access []

  context "for assigning attributes" do
    setup do
      @test = TestBase.new(1, @data)
      @test[:age] = 45
    end

    should "have new value assigned" do
      assert_equal 45, @test[:age]
    end
  end # assign []=

  context "for attribute_values method" do
    setup do
      @test = TestBase.new(1, @data)
      @test[:age] = 45
    end

    should "return attribute values in proper order as list" do
      assert_equal ["Bob", 45, "Red"], @test.attribute_values
    end
  end # attribute_values

  context "for changed? method" do
    setup do
      @test = TestBase.new(1, @data)
    end

    should "return false if not changed" do
      @test[:age] = 21
      assert_equal false, @test.changed?
    end

    should "return true if changed" do
      @test[:age] = 45
      assert_equal true, @test.changed?
    end
  end # attribute_values
end # Base