# == Schema Information
#
# Table name: technologies
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  slug       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_technologies_on_name  (name) UNIQUE
#  index_technologies_on_slug  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Technology, type: :model do
end
