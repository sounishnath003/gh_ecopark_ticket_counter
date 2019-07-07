class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.datetime :date
      t.integer :persons
      t.integer :price
      t.integer :sub_total

      t.timestamps
    end
  end
end
