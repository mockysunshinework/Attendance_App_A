class AddOvernightToAttedances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overnight, :boolean
  end
end
