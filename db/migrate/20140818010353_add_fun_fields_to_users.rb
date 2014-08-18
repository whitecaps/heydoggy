class AddFunFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends_character, :string
    add_column :users, :favourite_dog, :string
  end
end
