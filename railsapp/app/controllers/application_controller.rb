class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  before_action :authenticate_user!
  before_action :set_target_year
  
  rescue_from Net::LDAP::Error, with: :ldap_connection_error



def search
  phone_number = params[:phone_number]
  @search_results = []

  if phone_number.present?
    begin
      Rails.logger.info "Starting LDAP search for phone number: #{phone_number}"
      filter = Net::LDAP::Filter.construct("(|(telephoneNumber=#{phone_number})(mobile=#{phone_number}))")
      @search_results = Devise.ldap_search(phone_number, filter: filter)
      Rails.logger.info "LDAP search completed. Results: #{@search_results.inspect}"
    rescue Net::LDAP::Error => e
      Rails.logger.error "LDAP Error: #{e.message}"
      flash[:alert] = "LDAP Error: #{e.message}"
    rescue StandardError => e
      Rails.logger.error "Error: #{e.message}"
      flash[:alert] = "Error: #{e.message}"
    end
  end
  render template: 'tests/index'
end






  private

  def ldap_connection_error(exception)
    flash[:alert] = "LDAPサーバーへの接続に失敗しました。#{exception.message}"
    redirect_to new_user_session_path
  end

  def ldap_error_message
    strategy = failed_strategy
    return nil unless strategy&.is_a?(Devise::Strategies::LdapAuthenticatable)
    strategy.message.present? ? strategy.message : "LDAP通信に失敗しました。"
  end
  
  def failed_strategy
    opts = request.respond_to?(:get_header) ? request.get_header("warden.options") : request.env["warden.options"]
    opts ? opts[:strategy] : nil
  end
  helper_method :ldap_error_message

  def after_sign_in_path_for(resource)
    if current_user
      current_user.ldap_get_name_and_department
      stored_location_for(resource) || root_path
    else
      root_path
    end
  end

def set_target_year
  @target_year = Year.find_by(target_year: 1)&.year
end


end
