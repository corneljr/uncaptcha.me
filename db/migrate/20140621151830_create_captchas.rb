class CreateCaptchas < ActiveRecord::Migration
  def change
    create_table :captchas do |t|
      t.string :sequence
      t.string :image
      t.boolean :success
      t.boolean :read

      t.timestamps
    end
  end
end
