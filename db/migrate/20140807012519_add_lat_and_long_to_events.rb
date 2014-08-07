class AddLatAndLongToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lat, :decimal
    add_column :events, :long, :decimal
  end
end
