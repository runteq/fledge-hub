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
class Inquiry < ApplicationRecord
end
