require 'rails_helper'

RSpec.describe UserRegistrationService do
  let(:valid_params) { { email: 'user@example.com', password: 'password', password_confirmation: 'password' } }
  let(:invalid_params) { { email: 'user@example.com', password: 'password', password_confirmation: 'wrongpassword' } }

  describe '#call' do
    context 'Cuando los parámetros del usuario son válidos' do
      it 'Devuelve una respuesta de éxito con el usuario' do
        service = UserRegistrationService.new(valid_params)
        result = service.call

        expect(result[:success]).to be true
        expect(result[:user]).to be_a(User)
        expect(result[:user].email).to eq('user@example.com')
      end
    end

    context 'Cuando los parámetros del usuario no son válidos' do
      it 'Devuelve una respuesta de falla con mensajes de error.' do
        service = UserRegistrationService.new(invalid_params)
        result = service.call

        expect(result[:success]).to be false
        expect(result[:errors]).to include("Password confirmation doesn't match Password")
      end
    end
  end
end