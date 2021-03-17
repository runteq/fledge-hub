# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  display_name     :string(255)      not null
#  screen_name      :string(255)      not null
#  email            :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
end
