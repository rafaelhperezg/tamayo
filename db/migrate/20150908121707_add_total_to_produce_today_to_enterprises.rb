class AddTotalToProduceTodayToEnterprises < ActiveRecord::Migration
  def change
    add_column :enterprises, :current_employees, :integer
    add_column :enterprises, :current_prod_capacity, :integer
    add_column :enterprises, :current_to_produce, :integer
    add_column :enterprises, :est_manufactured_today, :integer
    add_column :enterprises, :est_delivery_time, :integer
    add_column :enterprises, :current_salaries, :integer
    add_column :enterprises, :current_raw_materials, :integer
    add_column :enterprises, :current_cost_hiring_firing, :integer
    add_column :enterprises, :current_contract_id, :integer
    add_column :enterprises, :est_total_sales_today, :integer
    add_column :enterprises, :est_net_result_today, :integer
  end
end
