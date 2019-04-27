# == Schema Information
#
# Table name: restaurants
#
#  id                    :bigint(8)        not null, primary key
#  name                  :string           not null
#  rating                :float            default(0.0)
#  accept10bis           :boolean          default(FALSE), not null
#  max_delivery_time_min :integer
#  address               :string
#  latitude              :float
#  longitude             :float
#  cuisine               :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Restaurant < ApplicationRecord

  validates :rating, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 3 }
  validates :name, presence: true
  validates :max_delivery_time_min, allow_nil: true,
                                    numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 0,
                                                    less_than_or_equal_to: 720 }


  validates :latitude, allow_nil: true, numericality:
                                        { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 90 }
  validates :longitude, allow_nil: true, numericality:
                                        { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 180 }


end
