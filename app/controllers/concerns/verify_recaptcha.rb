module VerifyRecaptcha
  extend ActiveSupport::Concern

  private

  def verify_recaptcha_v2(model)
    verify_recaptcha(
      model: model,
      secret_key: Rails.application.credentials.recaptcha_v2[:secret_key],
    )
  end

  def verify_recaptcha_v3(action)
    verify_recaptcha(
      action: action,
      minimum_score: 0.3,
      secret_key: Rails.application.credentials.recaptcha_v3[:secret_key],
    )
  end
end
