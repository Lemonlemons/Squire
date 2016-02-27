class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :is_female, :birthday,
              :firstname, :lastname, :phonenumber, :address, :country, :zipcode, :city, :password,
              :state, :country, :provider, :uid, :access_code, :publishable_key, :activequests,
              :completedquests, :totalcollected, :completedbasictraining, :completedquestionairre,
              :description, :question1, :question2, :question3, :question4, :question5, :numberofquestsflagged, :numberofreviews,
              :reviewpercentage, :numberofnotes, :completedstripe, :completedregistration, :completedinterview,
              :registrationcomplete, :profilepic, :mailingaddress,:mailingcity,:mailingstate,:mailingcountry,
              :mailingzipcode,:is_mailingsameasphysicaladdress,:physicaladdress,:physicalcity,:physicalstate,
              :physicalcountry,:physicalzipcode,:customertoken,:numberofquests) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :is_female, :birthday,
              :firstname, :lastname, :phonenumber, :address, :country, :zipcode, :city, :password,
              :state, :country, :provider, :uid, :access_code, :publishable_key, :activequests,
              :completedquests, :totalcollected, :completedbasictraining, :completedquestionairre,
              :description, :question1, :question2, :question3, :question4, :question5, :numberofquestsflagged, :numberofreviews,
              :reviewpercentage, :numberofnotes, :completedstripe, :completedregistration, :completedinterview,
              :completedregistration, :profilepic, :current_password, :password, :password_confirmation, :mailingaddress,:mailingcity,:mailingstate,:mailingcountry,
              :mailingzipcode,:is_mailingsameasphysicaladdress,:physicaladdress,:physicalcity,:physicalstate,
              :physicalcountry,:physicalzipcode,:customertoken,:numberofquests) }
        end
end
