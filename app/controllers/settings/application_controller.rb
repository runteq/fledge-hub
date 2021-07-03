module Settings
  class ApplicationController < ::ApplicationController
    before_action :require_login
    layout 'settings'
  end
end
