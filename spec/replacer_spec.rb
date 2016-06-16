require 'spec_helper'

describe Replacer do
  let(:replacer) { Replacer.new([*1..10]) }

  describe "initializer" do
    it "set range in initializer" do
      expect(replacer.range).to match_array([*1..10])
    end

    it "set iterations with empty array" do
      expect(replacer.iterations).to eq([])
    end
  end

  describe "#replace_multiples" do
    it "save replacements on iterations attribute" do
      replacer.replace_multiples(2, "test")
      expect(replacer.iterations).to match_array([
        [nil, "test", nil, "test", nil, "test", nil, "test", nil, "test"]
      ])
    end

    it "can have multiple iterations with range" do
      replacer.replace_multiples(2, "test")
      replacer.replace_multiples(5, "other")
      expect(replacer.iterations).to match_array([
        [nil, "test", nil, "test", nil, "test", nil, "test", nil, "test"],
        [nil, nil, nil, nil, "other", nil, nil, nil, nil, "other"]
      ])
    end
  end

  describe "#result" do
    it "returns empty array when no iteration whas made" do
      expect(replacer.result).to eq([])
    end

    it "replace different values with last iteration" do
      replacer.replace_multiples(2, "test")
      replacer.replace_multiples(5, "other")

      expect(replacer.result).to match_array(
        [1, "test", 3, "test", "other", "test", 7, "test", 9, "other"]
      )
    end

    it "not change range attribute" do
      replacer.replace_multiples(2, "test")
      replacer.replace_multiples(5, "other")

      expect(replacer.result).to match_array(
        [1, "test", 3, "test", "other", "test", 7, "test", 9, "other"]
      )

      expect(replacer.range).to match_array([*1..10])
    end

    it "can be called more then one time and update result" do
      replacer.replace_multiples(2, "test")

      expect(replacer.result).to match_array(
        [1, "test", 3, "test", 5, "test", 7, "test", 9, "test"]
      )

      replacer.replace_multiples(5, "other")

      expect(replacer.result).to match_array(
        [1, "test", 3, "test", "other", "test", 7, "test", 9, "other"]
      )
    end
  end

  describe "#replace_different_values" do
    it "replace different values for values in last array" do
      new_array = replacer.replace_different_values([1,2,3], [1,4,3])
      expect(new_array).to match_array([1,4,3])
    end
  end

end