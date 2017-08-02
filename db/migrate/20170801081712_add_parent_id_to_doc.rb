class AddParentIdToDoc < ActiveRecord::Migration[5.1]
  def change
  	add_column :docs, :parent_id, :bigint
  	add_column :docs, :child_id, :bigint
  	add_index :docs, :parent_id
  	add_index :docs, :child_id
  end
end
