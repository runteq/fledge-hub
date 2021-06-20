class InquiriesController < ApplicationController
  def new
    @inquiry_form = InquiryForm.new
  end

  def create
    @inquiry_form = InquiryForm.new(inquiry_params)

    if @inquiry_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry_form).permit(:name, :contact, :title,
                                         :description).merge(user_agent: request.user_agent)
  end
end
