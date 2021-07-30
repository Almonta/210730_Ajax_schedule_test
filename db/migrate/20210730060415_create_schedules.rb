class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :blog, foreign_key: true
      t.string :serial_number
      t.date :line_on

      t.timestamps
    end
  end
end
