class AddOvertimeBossToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overtime_boss, :integer
  end
end
