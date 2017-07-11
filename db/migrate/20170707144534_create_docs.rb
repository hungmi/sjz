class CreateDocs < ActiveRecord::Migration[5.1]
  def change
    drop_table :docs
    create_table :docs do |t|
      t.string :name, null: false
      t.string :code
      t.string :oss_key
      t.text :description
      t.text :note
      t.boolean :public
      t.boolean :iso, default: false

      t.timestamps
    end
    add_index :docs, :code, unique: true
    # add_index :docs, :oss_key, unique: true
  end
end
