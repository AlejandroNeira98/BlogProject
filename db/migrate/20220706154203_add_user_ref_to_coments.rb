class AddUserRefToComents < ActiveRecord::Migration[7.0]
  def change
    add_reference :coments, :user, null: false, foreign_key: true
  end
end
