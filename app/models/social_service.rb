class SocialService < ActiveHashMaster
  fields :id, :name, :icon, :base_url

  has_many :social_accounts

  alias service_name name
end
