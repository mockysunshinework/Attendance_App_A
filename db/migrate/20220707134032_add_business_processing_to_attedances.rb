class AddBusinessProcessingToAttedances < ActiveRecord::Migration[5.1]
  def change
    add_column :attedances, :business_processing, :string
  end
end
