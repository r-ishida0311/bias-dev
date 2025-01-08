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
      # Specify the attributes you want to retrieve.  Adjust these to your LDAP schema.
      filter = Net::LDAP::Filter.construct("(cn=*#{phone_number})")
      attributes = ["displayName", "department", "mail", "telephoneNumber"] 
      ldap_config = Devise.ldap_config
      ldap = Net::LDAP.new(
        host: ENV.fetch("LDAPHOST"),
        port: 389,
        base: "dc=ad,dc=mbs,dc=co,dc=jp",
        auth: {
          method: :simple,
          username: ENV.fetch("LDAPADMIN"),
          password: ENV.fetch("LDAPPASS")
        }
      )
      entries = ldap.search(filter: filter, attributes: attributes)

      #Process the search results into a more usable format
      @search_results = entries.map do |entry|
        {
          telephoneNumber: entry["telephoneNumber"].first,
          displayName: entry["displayName"].first,
          department: entry["department"].first,
          mail: entry["mail"].first
        }
      end
      Rails.logger.info "LDAP search completed. Results: #{@search_results.inspect}"
    rescue Net::LDAP::Error => e
      Rails.logger.error "LDAP Error: #{e.message}"
      flash[:alert] = "LDAP Error: #{e.message}"
      render json: [], status: :internal_server_error #Return JSON for error handling
      return
    rescue StandardError => e
      Rails.logger.error "Error: #{e.message}"
      flash[:alert] = "Error: #{e.message}"
      render json: [], status: :internal_server_error #Return JSON for error handling
      return
    end
  end

  # Return JSON response for better AJAX handling.  Updated in javascript as well
  render json: @search_results
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
