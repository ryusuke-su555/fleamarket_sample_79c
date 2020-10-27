class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :confingure_permitted_parameters, if: :devise_controller?

  private

  def production?
    Rails.env.production?
  end

  def confingure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [
      :nickname,
      :family_name,:first_name,
      :family_name_kana,:first_name_kana,
      :birthday,
      :zipcode, 
      :prefectures,
      :city,
      :address,
      :building,
      :address_name1,:address_name2,
      :phone,
      ])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
        password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

end
