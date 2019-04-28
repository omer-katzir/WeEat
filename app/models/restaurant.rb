# == Schema Information
#
# Table name: restaurants
#
#  id                    :uuid             not null, primary key
#  accept10bis           :boolean          default(FALSE), not null
#  address               :string
#  cuisine               :string
#  latitude              :float
#  longitude             :float
#  max_delivery_time_min :integer
#  name                  :string           not null
#  rating                :float            default(0.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Restaurant < ApplicationRecord
  validates :rating, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 3 }
  validates :name, presence: true
  validates :accept10bis, inclusion: [true, false]
  validates :max_delivery_time_min, allow_nil: true,
                                    numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 1,
                                                    less_than_or_equal_to: 720 }


  validates :latitude, allow_nil: true, numericality:
                                        { greater_than_or_equal_to: -90,
                                          less_than_or_equal_to: 90 }
  validates :longitude, allow_nil: true, numericality:
                                        { greater_than_or_equal_to: -180,
                                          less_than_or_equal_to: 180 }


  validates :id, uniqueness: true
end
