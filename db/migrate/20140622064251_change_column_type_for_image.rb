class ChangeColumnTypeForImage < ActiveRecord::Migration
  def change
    remove_column :captchas, :image, :string
    add_column :captchas, :image, :text
  end
end
