class CreateDailyCorruptionReports < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_corruption_reports do |t|
      t.date :day
      t.integer :total_cases
      t.integer :total_stolen_amount
      t.string :csv_file

      t.timestamps
    end
  end
end
