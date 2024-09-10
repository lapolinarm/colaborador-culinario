class Restaurant < ApplicationRecord
  validates :ruc, presence: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :commercial_name, :address, :district, :province, :country, presence: true

  belongs_to :user
  has_many :jobs, dependent: :destroy
end
