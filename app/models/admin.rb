# app/models/admin.rb
class Admin < User
  has_one :role, class_name: 'AdminRole'
  before_create create_admin_role

  def create_admin_role
    self.role = AdminRole.new
  end
end