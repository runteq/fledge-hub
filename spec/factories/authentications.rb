FactoryBot.define do
  factory :authentication do
    user
    provider { 'github' }
    uid { SecureRandom.uuid }
  end
end
