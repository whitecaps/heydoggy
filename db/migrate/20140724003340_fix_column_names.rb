class FixColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :events, :where, :location
    rename_column :events, :when, :starts_at
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
