class Job < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search,
    against: [:job_type, :description],
    using: {
      tsearch: { prefix: true }
    }

  def self.search_by_filters(search_term)
    scope = all

    if functions.key?(search_term.downcase)
      scope = scope.where(function: functions[search_term.downcase])
    end
    if job_modes.key?(search_term.downcase)
      scope = scope.where(job_mode: job_modes[search_term.downcase])
    end
    if job_types.key?(search_term.downcase)
      scope = scope.where(job_type: job_types[search_term.downcase])
    end
    if Restaurant.exists?(['LOWER(commercial_name) = ?', search_term.downcase])
      scope = scope.joins(:restaurant).where('LOWER(restaurants.commercial_name) = ?', search_term.downcase)
    end

    if scope.empty?
      scope = scope.where("description ILIKE ?", "%#{search_term}%")
    end
    scope
  end

  belongs_to :restaurant
  has_many :job_users, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :job_users

  enum function: { mozo: 0, azafata: 1, delivery: 2, lavaplatos: 3 }
  enum job_mode: { presencial: 0, hibrido: 1 }
  enum job_type: { fulltime: 0, parttime: 1 }
end
