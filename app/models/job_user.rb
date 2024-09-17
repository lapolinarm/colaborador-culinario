class JobUser < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum status: { aceptado: 0, pendiente: 1, rechazado: 2 }
end
