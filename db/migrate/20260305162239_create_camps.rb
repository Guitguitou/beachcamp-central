class CreateCamps < ActiveRecord::Migration[8.1]
  def change
    create_table :camps do |t|
      t.references :organizer, null: false, foreign_key: { to_table: :users }
      t.string  :title,            null: false
      t.text    :description
      t.string  :location,         null: false
      t.string  :country,          null: false
      t.date    :start_date,       null: false
      t.date    :end_date,         null: false
      t.integer :level,            null: false, default: 0
      t.integer :price_cents,      null: false, default: 0
      t.string  :currency,         null: false, default: "EUR"
      t.integer :min_participants, null: false, default: 4
      t.integer :max_participants, null: false, default: 16
      t.integer :status,           null: false, default: 0
      t.boolean :featured,         null: false, default: false

      t.timestamps
    end
  end
end
