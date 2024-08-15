require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'Es un factory valido' do
    expect(FactoryBot.build(:product)).to be_valid
  end

  it 'No es válido sin name' do
    product = FactoryBot.build(:product, name: nil)
    expect(product).not_to be_valid
  end

  it 'No es válido sin price' do
    product = FactoryBot.build(:product, price: nil)
    expect(product).not_to be_valid
  end
end