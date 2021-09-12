class AddUserReferencesToCorruptionCases < ActiveRecord::Migration[6.1]
  def change
    change_table :corruption_cases do |t|
      t.references :user, index: true
    end
  end
end
