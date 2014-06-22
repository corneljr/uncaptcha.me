class AddUserIdToCaptchas < ActiveRecord::Migration
  def change
    add_reference :captchas, :user, index: true
  end
end
