class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :pub_key
      t.string :priv_key

      t.timestamps
    end
  end
end
