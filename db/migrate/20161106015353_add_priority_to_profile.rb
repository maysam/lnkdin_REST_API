class AddPriorityToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :priority, :integer, :null => false, :default => 2
  end
end
