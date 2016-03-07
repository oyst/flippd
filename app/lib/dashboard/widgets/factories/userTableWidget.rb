require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
class UserTableWidget
  def self.create(data)
    email  = TableColumn.new('Email', 'email')
    view_dashboard = TableColumn.new('Dashboard', 'id', '')
    columns = [email, view_dashboard]
    TableWidget.new(columns, data, 'My Students')
  end
end
