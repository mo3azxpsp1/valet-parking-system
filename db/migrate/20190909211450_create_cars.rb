class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :owner
      t.integer :plate_no

      t.timestamps
    end
  end
end
