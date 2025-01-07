class Users::SessionsController < Devise::SessionsController
  before_action :ldap_error_message, only: [:new]


end