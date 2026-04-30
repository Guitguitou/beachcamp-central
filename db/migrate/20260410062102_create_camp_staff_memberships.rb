class CreateCampStaffMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :camp_staff_memberships do |t|
      t.references :camp, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :camp_staff_memberships, [:camp_id, :user_id], unique: true
  end
end
