class CreatePins < ActiveRecord::Migration[5.1]
  def change
    create_table :pins do |t|
      t.string :file
      t.belongs_to :pinnable, :polymorphic => true

      t.timestamps
    end
  end
end
