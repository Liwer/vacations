class AddEmploymentdateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :employment_date, :date
  end
end
