class Car < ApplicationRecord
    attr_accessor :bay_id
    has_many :bays_cars,   dependent: :destroy
    has_many :bays,        through: :bays_cars
end
