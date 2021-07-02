module Settings
  class ApplicationController < ::ApplicationController
    before_action :require_login
  end
end
