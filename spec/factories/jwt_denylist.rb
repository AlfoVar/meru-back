FactoryBot.define do
  factory :jwt_denylist do
    jti { "some-jti" }
    exp { 1.day.from_now }
  end
end