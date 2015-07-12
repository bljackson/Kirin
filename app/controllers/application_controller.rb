class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

	  def add_breadcrumb name, url = ''
	    @breadcrumbs ||= []
	    url = eval(url) if url =~ /_path|_url|@/
	    @breadcrumbs << [name, url]
	  end
	 
	  def self.add_breadcrumb name, url, options = {}
	    before_filter options do |controller|
	      controller.send(:add_breadcrumb, name, url)
	    end
	  end

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :terms_of_service) }
	  end

  	add_breadcrumb 'Home', '/'
	end
