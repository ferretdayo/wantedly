class CreateTagUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_users do |t|
      t.references :user_id, foreign_key: true
      t.references :tag_id, foreign_key: true

      t.timestamps
    end
  end
end
