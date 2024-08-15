require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  it 'Es valido el factory' do
    expect(FactoryBot.build(:jwt_denylist)).to be_valid
  end

  it 'Es inválido sin un jti' do
    jwt_denylist = FactoryBot.build(:jwt_denylist, jti: nil)
    expect(jwt_denylist).not_to be_valid
  end
end