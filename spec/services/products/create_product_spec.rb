require 'rails_helper'

RSpec.describe Products::CreateProduct, type: :service do
    describe '#call' do
    let(:valid_params) { { name: 'Product Name', description: 'Product Description', price: 100.00 } }
    let(:invalid_params) { { name: '', description: '', price: nil } }

    context 'Cuando los parámetros son válidos' do
      it 'Crea un nuevo producto y devuelve success' do
        service = Products::CreateProduct.new(valid_params)
        result = service.call

        expect(result[:success]).to be true
        expect(result[:product]).to be_a(Product)
        expect(result[:product].name).to eq('Product Name')
        expect(result[:product].description).to eq('Product Description')
        expect(result[:product].price).to eq(100.00)
      end
    end

    context 'Cuando los parámetros no son válidos' do
      it 'No crea un nuevo producto y devuelve un error' do
        service = Products::CreateProduct.new(invalid_params)
        result = service.call

        expect(result[:success]).to be false
        expect(result[:error]).to eq('Invalid parameters')
      end
    end

    it 'Devuelve un error por datos de producto no válidos.' do
      invalid_product_params = { name: 'Producto de prueba', description: 'Descripción del producto de prueba', price: 'invalid' }
      service = Products::CreateProduct.new(invalid_product_params)
      result = service.call

      expect(result[:success]).to be false
      expect(result[:error]).to include('Invalid parameters')
    end
  end
end