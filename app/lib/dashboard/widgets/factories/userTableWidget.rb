require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
class UserTableWidget
  def self.create(data)
    email  = TableColumn.new('Email', 'email')
    id_to_link = lambda { |id| "<a href='/dashboard/" + id.to_s + "'>Go to dashboard</a>" }
    view_dashboard = TableColumn.new('Dashboard', 'id', '', id_to_link)
    columns = [email, view_dashboard]
    TableWidget.new(columns, data, 'My Students')
  end
end
