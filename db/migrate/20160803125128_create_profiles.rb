class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :json
      t.text :link

      t.timestamps null: false
    end
  end
end
