class CreateComents < ActiveRecord::Migration[7.0]
  def change
    create_table :coments do |t|
      t.text :text

      t.timestamps
    end
  end
end
