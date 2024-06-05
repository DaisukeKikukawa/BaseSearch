class Tournament < ApplicationRecord
  has_many :tournament_records, dependent: :destroy
  has_one :article, as: :belongable

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["article", "tournament_records"]
  end
end
