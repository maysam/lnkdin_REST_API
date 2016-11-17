class AddCallbackToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :callback, :string
  end
end
