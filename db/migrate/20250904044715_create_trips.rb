class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
