class InquiriesController < ApplicationController
  include VerifyRecaptcha

  def new
    @inquiry_form = InquiryForm.new
  end

  def create
    @inquiry_form = InquiryForm.new(inquiry_params)
    @recaptcha_valid = verify_recaptcha_v3('inquiry') || verify_recaptcha_v2

    if @recaptcha_valid && @inquiry_form.valid?
      @inquiry_form.save
      redirect_to root_path, notice: '送信しました！'
    else
      if recaptcha_reply&.dig('error-codes')
        error_codes = recaptcha_reply['error-codes'].join(', ')
        Rails.logger.warn("
          An inquiry from #{@inquiry_form.name} was denied because of recaptcha error-codes: #{error_codes}
        ")
        flash.now[:alert] = error_codes
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
