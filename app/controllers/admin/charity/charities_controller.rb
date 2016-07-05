class Admin::Charity::CharitiesController <ApplicationController

  def edit
    @charity = Charity.find(params[:id])
    @cause_options = Cause.form_options
  end

  def update
    @charity = Charity.find(params[:id])
    @charity.update(charity_params)
    # @charity.causes_charities.last.update_attributes(causes_charities_params)
    if current_user.platform_admin?
      redirect_to admin_dashboard_path
    else
      redirect_to admin_charity_dashboard_path(@charity.slug)
    end
  end

  private


  def charity_params
  params.require(:charity).permit(:name, :description, :charity_photo, :tagline, :causes_charities)
  end

  def causes_charities_params
  params.require(:causes_charities).permit(:cause_id)
  end



end
