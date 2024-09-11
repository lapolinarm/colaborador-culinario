class ChangeRucString < ActiveRecord::Migration[7.1]
  def change
    change_column :restaurants, :ruc, :string
  end
end
