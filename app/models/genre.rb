class Genre < ActiveYaml::Base
  set_root_path Rails.root.join('db/fixtures')
  set_filename 'genre'
end
