class AddFolderIdToDocs < ActiveRecord::Migration[5.1]
  def change
    add_reference :docs, :folder, foreign_key: true
  end
end
