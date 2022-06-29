class Base < ApplicationRecord
  validates :base_name, presence: true
  validates :base_number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999999}
  validates :attendance_type, presence: true
end
