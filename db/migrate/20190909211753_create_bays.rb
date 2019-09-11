class CreateBays < ActiveRecord::Migration[5.2]
  def change
    create_table :bays do |t|
      t.integer :number
      t.integer :size
      t.boolean :is_available

      t.timestamps
    end
  end
end
