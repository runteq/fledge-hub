class SocialService < ActiveHashMaster
  fields :id, :position, :name, :icon, :base_url

  has_many :social_accounts

  alias service_name name

  class << self
    def twitter
      find_by!(name: 'Twitter')
    end
  end
end
