class SocialService < ActiveHashMaster
  fields :id, :position, :name, :icon, :base_url

  has_many :social_accounts

  alias service_name name
end
