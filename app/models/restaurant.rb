class Restaurant < ApplicationRecord
  validates :ruc, presence: true, length: { is: 11 }
  validates :commercial_name, :address, :district, :province, presence: true # quite country por le momento

  belongs_to :user
  has_many :jobs, dependent: :destroy
end
