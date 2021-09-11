class CreateCorruptionCases < ActiveRecord::Migration[6.1]
  def change
    create_table :corruption_cases do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.integer :stolen_amount
      t.text :place
      t.datetime :trial_start_at
      t.datetime :sentenced_at
      t.integer :sentence
      t.string :european_funds_project

      t.timestamps
    end
  end
end
