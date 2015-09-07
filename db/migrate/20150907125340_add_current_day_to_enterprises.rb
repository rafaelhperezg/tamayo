class AddCurrentDayToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :current_day, :integer
  end
end
