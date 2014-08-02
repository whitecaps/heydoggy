class MakeRegistrationsAJoinTable < ActiveRecord::Migration
  def change
  	def up
    Registration.delete_all
    remove_column :registrations, :name
    add_column    :registrations, :user_id, :integer
  end 

  def down
    Registration.delete_all
    remove_column :registrations, :user_id
    add_column    :registrations, :name,  :string
  end

  end
end