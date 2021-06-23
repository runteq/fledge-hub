# == Schema Information
#
# Table name: inquiries
#
#  id          :bigint           not null, primary key
#  about       :string(255)      not null
#  description :text(65535)      not null
#  email       :string(255)
#  name        :string(255)      not null
#  user_agent  :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :inquiry do
    sequence(:name, "名前_1")
    sequence(:email, "メールアドレス_1")
    sequence(:about, "項目_1")
    sequence(:description, "内容_1")
    sequence(:user_agent, "UserAgent_1")
  end
end
