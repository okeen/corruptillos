class AddDefaultValueToMoneyFields < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:daily_corruption_reports, :total_cases, 0)
    change_column_default(:daily_corruption_reports, :total_stolen_amount, 0)
    change_column_default(:corruption_cases, :stolen_amount, 0)
  end
end
