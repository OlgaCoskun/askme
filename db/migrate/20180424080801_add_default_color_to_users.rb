class AddDefaultColorToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :color, :string, :default => "#000555"
  end
end
