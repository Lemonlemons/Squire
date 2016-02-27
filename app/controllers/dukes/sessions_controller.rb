class Dukes::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super
    cookies[:username] = current_duke.email
  end

  # GET /resource/sign_out
  def destroy
    super
  end
end
