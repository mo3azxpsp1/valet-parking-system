class CreateJoinTableBaysCars < ActiveRecord::Migration[5.2]
  def change
    create_table :bays_cars do |t|
      t.integer :bay_id
      t.integer :car_id
      t.datetime :parked_at
      t.datetime :left_at

      t.timestamps
    end
  end
end
