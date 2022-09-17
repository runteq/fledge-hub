class InquiriesController < ApplicationController
  def new
    @inquiry_form = InquiryForm.new
  end

  def create
    @inquiry_form = InquiryForm.new(inquiry_params)
    recaptcha_valid = verify_recaptcha(action: 'inquiry', minimum_score: 0.3,
                                       secret_key: Recaptcha.configuration.secret_key)
    if recaptcha_valid && @inquiry_form.save
      redirect_to root_path, notice: '送信しました！'
    else
      if recaptcha_reply
        error_codes = recaptcha_reply['error-codes'].join(', ')
        Rails.logger.warn("
          An inquiry from #{@inquiry_form.name} was denied because of recaptcha error-codes: #{error_codes}
        ")
      end
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry_form).permit(
      :name,
      :email,
      :about,
      :description,
    ).merge(
      user_agent: request.user_agent,
      current_user: current_user,
    )
  end
end
