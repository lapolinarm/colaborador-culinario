class Job < ApplicationRecord
  belongs_to :restaurant
  has_many :job_users, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
