class RemoveEmailHowHeardFromUsers < ActiveRecord::Migration
  def up
  	Registration.delete_all
  	remove_column :registrations, :email
  	remove_column :registrations, :how_heard
  end

  def down
  	Registration.delete_all
  	add_column :registrations, :how_heard, :string
  	add_column :registrations, :email, :string
  end
end
