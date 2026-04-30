class AddCoachProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :slug, :string
    add_column :users, :coach_headline, :string
    add_column :users, :coach_bio, :text
    add_column :users, :coach_track_record, :text
    add_index :users, :slug, unique: true
  end
end
