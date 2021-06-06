class ActiveHashMaster < ActiveYaml::Base
  def self.inherited(klass)
    super

    klass.set_root_path Rails.root.join('db/fixtures')
    klass.set_filename klass.to_s.underscore.singularize
  end
end
