class AddCurrentCashToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :current_cash, :integer
  end
end
