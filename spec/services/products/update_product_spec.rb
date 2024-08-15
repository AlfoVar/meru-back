require 'rails_helper'

RSpec.describe Products::UpdateProduct, type: :service do
  let(:product) do
    product = Product.new(name: 'Producto 1', description: 'Descripción del producto', price: 100.0)
    product.save
    product
  end
  let(:valid_params) { { name: 'Producto actualizado', description: 'Descripción actualizada', price: 150.0 } }
  let(:invalid_params) { { name: '', description: '', price: nil } }

  it 'Actualiza un producto con los atributos correctos' do
    service = described_class.new(product, valid_params)
    result = service.call

    expect(result[:success]).to be true
    expect(result[:product]).to eq(product)
    expect(result[:product].name).to eq('Producto actualizado')
    expect(result[:product].description).to eq('Descripción actualizada')
    expect(result[:product].price).to eq(150.0)
  end

  context 'Con parámetros inválidos' do
    it 'devuelve un error para parámetros no válidos' do
      service = Products::UpdateProduct.new(product, invalid_params)
      result = service.call

      expect(result[:success]).to be false
      expect(result[:errors]).to eq('Parametros invalidos')
    end

    it 'devuelve un error por datos de producto no válidos.' do
      invalid_product_params = { name: 'Producto actualizado', description: 'Descripción actualizada', price: 'invalid' }
      service = Products::UpdateProduct.new(product, invalid_product_params)
      result = service.call

      expect(result[:success]).to be false
      expect(result[:errors]).to include('Parametros invalidos')
    end
  end
end