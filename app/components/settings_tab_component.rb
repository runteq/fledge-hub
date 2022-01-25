# frozen_string_literal: true

class SettingsTabComponent < ViewComponent::Base
  def initialize(tab_name:, tab_path:)
    @tab_name = tab_name
    @tab_path = tab_path
    super
  end

  private

  attr_reader :tab_name, :tab_path
end
