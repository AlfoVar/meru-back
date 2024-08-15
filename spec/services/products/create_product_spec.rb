require 'rails_helper'

RSpec.describe Products::CreateProduct, type: :service do
    describe '#call' do
    let(:valid_params) { { name: 'Product Name', description: 'Product Description', price: 100 } }
    let(:invalid_params) { { name: '', description: 'Product Description', price: 100 } }

    context 'Cuando los parámetros son válidos' do
      it 'Crea un nuevo producto y devuelve success' do
        service = Products::CreateProduct.new(valid_params)
        result = service.call

        expect(result[:success]).to be true
        expect(result[:product]).to be_a(Product)
        expect(result[:product].name).to eq('Product Name')
      end
    end

    context 'Cuando los parámetros no son válidos' do
      it 'No crea un nuevo producto y devuelve un error' do
        service = Products::CreateProduct.new(invalid_params)
        result = service.call

        expect(result[:success]).to be false
        expect(result[:error]).to be_present
      end
    end
  end
end