class ActiveHashMaster < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path Rails.root.join('db/fixtures')

  def self.inherited(klass)
    super

    klass.set_filename klass.to_s.underscore.singularize
  end
end
