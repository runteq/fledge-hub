# == Schema Information
#
# Table name: inquiries
#
#  id          :bigint           not null, primary key
#  about       :string(255)      not null
#  description :text(65535)      not null
#  email       :string(255)      default(""), not null
#  name        :string(255)      not null
#  user_agent  :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Inquiry < ApplicationRecord
  validates :name, :about, :description, :user_agent, presence: true
end
