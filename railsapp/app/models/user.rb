class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :ldap_authenticatable, :registerable,
        #  :recoverable, :rememberable, :validatable
        devise :ldap_authenticatable, :rememberable, :trackable
#  def ldap_get_display_name
#     ldap_entry = Devise::LDAP::Adapter.get_ldap_entry(login)
#     if ldap_entry.respond_to?(:displayname) && ldap_entry.displayname.present?
#       ldap_entry.displayname.first.force_encoding('UTF-8')
#     else
#       ''
#     end
    
#     if ldap_entry.respond_to?(:department) && ldap_entry.department.present?
#       ldap_entry.department.first.force_encoding('UTF-8')
#     else
#       ''
#     end
#   end

def ldap_get_name_and_department
  ldap_entry = Devise::LDAP::Adapter.get_ldap_entry(login)
  self.login_user = ldap_entry.respond_to?(:displayname) && ldap_entry.displayname.present? ? ldap_entry.displayname.first.force_encoding('UTF-8') : ''
  self.login_department = ldap_entry.respond_to?(:department) && ldap_entry.department.present? ? ldap_entry.department.first.force_encoding('UTF-8') : ''
  self.login_ref_no = ldap_entry.respond_to?(:telephonenumber) && ldap_entry.telephonenumber.present? ? ldap_entry.telephonenumber.first.force_encoding('UTF-8') : ''
  # self.groups = ldap_entry.memberof.map { |group| group.force_encoding('UTF-8') }
  self.save
end

  
end