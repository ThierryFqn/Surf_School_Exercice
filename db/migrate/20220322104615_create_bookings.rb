class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.date :begin_date
      t.date :end_date
      t.integer :total_price

      t.timestamps
    end
  end
end
