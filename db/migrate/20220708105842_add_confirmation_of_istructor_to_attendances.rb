class AddConfirmationOfIstructorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :confirmation_of_instructor, :integer
  end
end
