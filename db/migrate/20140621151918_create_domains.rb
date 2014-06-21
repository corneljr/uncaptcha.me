class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
