class Job < ApplicationRecord
  belongs_to :restaurant
  has_many :job_users, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def location
    "#{restaurant.province}, #{restaurant.country}"
  end

  enum function: { mozo: 0, azafata: 1, delivery: 2, lavaplatos: 3 }

end
