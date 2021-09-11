class AddIndexToCasesSlug < ActiveRecord::Migration[6.1]
  def change
    add_index :corruption_cases, :slug
  end
end
