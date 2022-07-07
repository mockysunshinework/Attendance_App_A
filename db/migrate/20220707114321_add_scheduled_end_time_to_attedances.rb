class AddScheduledEndTimeToAttedances < ActiveRecord::Migration[5.1]
  def change
    add_column :attedances, :scheduled_end_time, :datetime
  end
end
