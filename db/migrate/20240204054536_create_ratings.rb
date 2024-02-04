class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :place_id
      t.float :value

      t.timestamps
    end
  end
end
