class ActiveHashMaster < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path Rails.root.join('db/fixtures')

  def self.inherited(klass)
    super

    klass.set_filename klass.to_s.underscore.singularize
  end

  # TODO: いずれかの継承先で使えなくなったらモジュールにする
  def self.asc
    all.sort_by(&:position)
  end
end
