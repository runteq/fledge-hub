# == Schema Information
#
# Table name: authentications
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Authentication < ApplicationRecord
  belongs_to :user
end
