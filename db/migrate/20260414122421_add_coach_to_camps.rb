class AddCoachToCamps < ActiveRecord::Migration[8.1]
  def change
    add_reference :camps, :coach, null: true, foreign_key: { to_table: :users }
  end
end
