class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable


  has_many :restaurants, dependent: :destroy
  has_many :job_users, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :jobs, through: :job_users

  # Definir los roles
  enum role: { owner: 0, collaborator: 1 }

  # Validations
  validates :role, presence: true
end
