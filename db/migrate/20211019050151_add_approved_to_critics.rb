class AddApprovedToCritics < ActiveRecord::Migration[6.1]
  def change
    add_column :critics, :approved, :boolean, default: false
  end
end
