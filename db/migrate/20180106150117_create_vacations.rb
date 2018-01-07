class CreateVacations < ActiveRecord::Migration[5.1]
  def change
    create_table :vacations do |t|
      t.date :start_date
      t.date :end_date
      t.text :description

      t.timestamps
    end
  end
end
