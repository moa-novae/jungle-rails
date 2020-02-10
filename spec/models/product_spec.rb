require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do 
      @product = Product.new
      @category= Category.new
      category = @category
      product = @product
      product.name = 'Name'
      product.price = 10
      product.quantity = 10
      product.category = category
    end
    it 'is valid when all field filled' do
      expect(@product).to be_valid
    end
    it 'is not valid when name is not filled' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.first).to include("can't be blank")
    end
    it 'is not valid when price is not filled' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.first).to include("is not a number")      
    end
    it 'is not valid when quantity is not filled' do 
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.first).to include("can't be blank")
    end 
    it 'is not valid when category is not filled' do 
      @product.category = nil 
      expect(@product).to_not be_valid 
      expect(@product.errors.first).to include("can't be blank")
    end

  end
end
