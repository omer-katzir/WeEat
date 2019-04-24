class Restaurant < ApplicationRecord

  validates :rating, numericality: {  only_integer: true,
                                      greater_than_or_equal_to: 0,
                                      less_than_or_equal_to: 3 }
  validates :name, presence: true
  validates :max_delivery_time_min, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 1,
                                                    less_than_or_equal_to: 720 }

end
