# == Schema Information
#
# Table name: inquiries
#
#  id          :bigint           not null, primary key
#  contact     :string(255)
#  description :text(65535)      not null
#  name        :string(255)      not null
#  title       :string(255)      not null
#  user_agent  :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :inquiry do
    sequence(:name, "名前_1")
    sequence(:contact, "連絡先_1")
    sequence(:title, "タイトル_1")
    sequence(:description, "内容_1")
    sequence(:user_agent, "UserAgent_1")
  end
end
