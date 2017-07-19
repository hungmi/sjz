class CreateDocs < ActiveRecord::Migration[5.1]
  def change
    create_table :docs do |t|
      t.string :name, null: false
      t.string :code
      t.text :description
      t.text :note
      t.boolean :public
      t.boolean :iso, default: false

      t.timestamps
    end
    add_index :docs, :code, unique: true
  end
end