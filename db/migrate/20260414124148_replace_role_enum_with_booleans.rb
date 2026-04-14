class ReplaceRoleEnumWithBooleans < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :admin,     :boolean, default: false, null: false
    add_column :users, :coach,     :boolean, default: false, null: false
    add_column :users, :organizer, :boolean, default: false, null: false

    # Migrate existing data: role enum was player=0, organizer=1, admin=2, coach=3
    execute <<~SQL
      UPDATE users SET admin     = TRUE WHERE role = 2;
      UPDATE users SET coach     = TRUE WHERE role = 3;
      UPDATE users SET organizer = TRUE WHERE role = 1;
    SQL

    remove_column :users, :role
  end

  def down
    add_column :users, :role, :integer, default: 0, null: false

    execute <<~SQL
      UPDATE users SET role = 2 WHERE admin = TRUE;
      UPDATE users SET role = 1 WHERE organizer = TRUE AND admin = FALSE;
      UPDATE users SET role = 3 WHERE coach = TRUE AND admin = FALSE AND organizer = FALSE;
    SQL

    remove_column :users, :admin
    remove_column :users, :coach
    remove_column :users, :organizer
  end
end
