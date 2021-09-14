class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :name
    end
  end
end
