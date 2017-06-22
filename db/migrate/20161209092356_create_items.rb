class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :spec
      t.string :quantity
      t.string :unit
      # t.string :token
      # t.text :qr_code
      t.string :image
      t.belongs_to :department, foreign_key: true, index: true
      t.belongs_to :employee, foreign_key: true, index: true

      t.timestamps
    end
  end
end
