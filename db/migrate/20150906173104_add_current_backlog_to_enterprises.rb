class AddCurrentBacklogToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :current_backlog, :integer
  end
end
