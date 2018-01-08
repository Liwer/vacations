class AddVacationDaysToVacation < ActiveRecord::Migration[5.1]
  def change
    add_column :vacations, :days_count, :integer
  end
end
