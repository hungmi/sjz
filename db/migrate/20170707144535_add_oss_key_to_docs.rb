class AddOssKeyToDocs < ActiveRecord::Migration[5.1]
  def change
    add_column :docs, :oss_key, :string
    add_index :docs, :oss_key, unique: true
  end
end