class ApplicationController < ActionController::Base
  
  include Clearance::Authentication
  include Clearance::Admin
  
  protect_from_forgery
  
    # this unless doesn't work as expected probably because
    # config is not initialized yet at this point
    unless TRUE or config.consider_all_requests_local
      
      # Default case: generic application error
      rescue_from Exception, :with => :render_error
      
      # Model-related errors
      rescue_from ActiveRecord::ActiveRecordError, :with => :render_model_error
      
      # Cases in which "not found" has some sense instead
      rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
      rescue_from ActionController::RoutingError, :with => :render_not_found
      rescue_from ActionController::UnknownController, :with => :render_not_found
      rescue_from ActionController::UnknownAction, :with => :render_not_found
    end  

  private
  
  def render_not_found(exception)
    render :template => "/errors/404.html.erb", :status => 404
  end

  def render_model_error(exception)
    render :template => "/errors/501.html.erb", :status => 501
  end
  
  def render_error(exception)
    render :template => "/errors/500.html.erb", :status => 500
  end

end