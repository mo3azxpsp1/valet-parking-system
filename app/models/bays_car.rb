class BaysCar < ApplicationRecord
    # Relations
    belongs_to :bay,             class_name: "Bay",        foreign_key: :bay_id
    belongs_to :car,             class_name: "Car",        foreign_key: :car_id
end
