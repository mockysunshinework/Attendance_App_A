class AddOvernightToAttedances < ActiveRecord::Migration[5.1]
  def change
    add_column :attedances, :overnight, :boolean
  end
end
