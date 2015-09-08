class AddEstNewBacklogToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :est_new_backlog, :integer
  end
end
