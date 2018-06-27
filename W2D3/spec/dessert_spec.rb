require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Mojabe") }
  subject(:brownie) { Dessert.new('brownie', 50, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eq("brownie")
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect {Dessert.new("brownie","tons",chef) }.to raise_error()
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      brownie.add_ingredient("milk")
      expect(brownie.ingredients).to include("milk")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      sample_ingredients = ["milk","eggs","soy sauce","horse radish"]
      sample_ingredients.each { |ingr| brownie.add_ingredient(ingr) }

      expect(brownie.ingredients).to eq(sample_ingredients)
      brownie.mix!
      expect(brownie.ingredients).not_to eq(sample_ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      quantity = brownie.quantity
      brownie.eat(1)
      expect(quantity).not_to eq(brownie.quantity)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{ brownie.eat(55) }.to raise_error('not enough left!')
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Mojabe the Great Baker")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(brownie)
      brownie.make_more
    end
  end
end
