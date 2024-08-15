require 'rails_helper'

RSpec.describe UserLoginService do
  let!(:user) do
    user = build(:user, email: 'user@example.com', password: 'password')
    unless user.save
      puts user.errors.full_messages
    end
    user
  end
  let(:valid_email) { 'user@example.com' }
  let(:valid_password) { 'password' }
  let(:invalid_password) { 'contraseña incorrecta' }

  describe '#call' do
    context 'Cuando las credenciales son correctas' do
      it 'devuelve una respuesta de éxito con un token' do
        service = UserLoginService.new(valid_email, valid_password)
        result = service.call

        expect(result[:success]).to be true
        expect(result[:token]).not_to be_nil
      end
    end

    context 'Cuando el correo electrónico es incorrecto' do
      it 'devuelve una respuesta de falla con un mensaje de error.' do
        service = UserLoginService.new(valid_email, invalid_password)
        result = service.call

        expect(result[:success]).to be false
        expect(result[:errors]).to include('Usuario o contraseña invalidos')
      end
    end
  end
end