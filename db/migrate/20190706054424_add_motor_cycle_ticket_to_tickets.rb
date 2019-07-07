class AddMotorCycleTicketToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :motorcycle_parking, :boolean
  end
end
