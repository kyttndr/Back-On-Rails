class Place < ApplicationRecord

  belongs_to :user
  has_many :items, dependent: :destroy

  geocoded_by :address, latitude: :lat, longitude: :lon
  before_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  before_validation :reverse_geocode, unless: ->(obj) { obj.address.present? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
  reverse_geocoded_by :latitude, :longitude

  validates :address, presence: true
  validate :address_exist

  def address_exist
      if !latitude || !longitude
          errors.add(:address, "Address does not exist! ")
      end
  end

end
