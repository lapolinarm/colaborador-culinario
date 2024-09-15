class Job < ApplicationRecord
  belongs_to :restaurant
  has_many :job_users, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :job_users

  enum job_mode: { presencial: 0, hibrido: 1 }
  enum function: { mozo: 0, azafata: 1, delivery: 2, lavaplatos: 3 }

end
