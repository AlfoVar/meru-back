require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Es un factory valido' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'No es válido sin email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'No es válido sin password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end
end