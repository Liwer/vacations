class Vacation < ApplicationRecord
	belongs_to :user
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates_uniqueness_of :start_date, scope: :user_id
	validates_uniqueness_of :end_date, scope: :user_id

	 def transform_vacation_to_years_days
	 	return (self.start_date.yday..self.end_date.yday).to_a
	 end
end
