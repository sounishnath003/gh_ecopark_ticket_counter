class Ticket < ApplicationRecord
    validates :date, presence: :true
    validates :persons, presence: :true
    validates :price, presence: :true

    belongs_to :user

end
