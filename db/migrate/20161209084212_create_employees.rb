class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :title
      t.string :name
      t.string :mobile_phone
      t.string :tel
      t.string :ext
      t.belongs_to :department, foreign_key: true, index: true

      t.timestamps
    end
  end
end
