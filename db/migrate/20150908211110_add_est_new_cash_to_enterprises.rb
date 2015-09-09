class AddEstNewCashToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :est_new_cash, :integer
  end
end
