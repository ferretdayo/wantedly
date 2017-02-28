class CreateTaggerUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tagger_users do |t|
      t.references :tag_user, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
