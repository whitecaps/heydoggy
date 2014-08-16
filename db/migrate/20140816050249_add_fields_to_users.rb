class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :breed, :string
    add_column :users, :birthday, :date
    add_column :users, :age, :integer
    add_column :users, :favourite_toy, :string
    add_column :users, :favourite_pasttime, :string
    add_column :users, :reason_loved, :string
  end
end
