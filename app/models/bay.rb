class Bay < ApplicationRecord
    enum size: {single: 0, double: 1}

    has_many :bays_cars,   dependent: :destroy
    has_many :cars,        through: :bays_cars

    def no_of_parking_cars
        bays_cars.where.not(parked_at: nil).where(left_at: nil).size
    end
end
