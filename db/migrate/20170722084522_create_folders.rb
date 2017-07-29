class CreateFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.bigint :parent_id

      t.timestamps
    end
    add_index :folders, :name
  end
end