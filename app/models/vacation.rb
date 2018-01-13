class Vacation < ApplicationRecord
	belongs_to :user
	 validates_uniqueness_of :start_date, scope: :user_id
	 validates_uniqueness_of :end_date, scope: :user_id
end
