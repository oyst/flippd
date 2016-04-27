require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
require_relative 'decorators/link'
class UserTableWidget
  def self.create(data)
    email  = TableColumn.new('Email', 'email')
    view_dashboard = TableColumn.new('Dashboard', 'id', Link.create('/dashboard/', 'Go to dashboard'))
    columns = [email, view_dashboard]
    TableWidget.new(columns, data, 'My Students')
  end
end
