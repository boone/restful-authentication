# This controller handles the login/logout function of the site.  
class <%= controller_class_name %>Controller < ApplicationController
  # include Authenticated<%= class_name %>System in any controllers using this authentication
  include Authenticated<%= class_name %>System

  # render new.rhtml
  def new
  end

  def create
    self.current_<%= file_name %> = <%= class_name %>.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_<%= file_name %>.remember_me unless current_<%= file_name %>.remember_token?
        cookies[:auth_<%= file_name %>_token] = { :value => self.current_<%= file_name %>.remember_token , :expires => self.current_<%= file_name %>.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_<%= file_name %>.forget_me if logged_in?
    cookies.delete :auth_<%= file_name %>_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
