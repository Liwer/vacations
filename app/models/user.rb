class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :vacations, dependent: :destroy

	def calculate
		@working_years = DateTime.now.year - employment_date.year

		balance = 21 * @working_years

		@vacation_days = []
		self.vacations.each do |vacation|
			@vacation_days.push(vacation.days_count)
		end
		@all_vacation_days = @vacation_days.inject(0){|sum,x| sum + x }	

		
		self.balance = balance - @all_vacation_days
		self.save
	end
end
