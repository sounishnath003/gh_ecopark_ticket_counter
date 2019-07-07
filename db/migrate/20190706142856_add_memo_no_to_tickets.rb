class AddMemoNoToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :memo_no, :integer
  end
end
