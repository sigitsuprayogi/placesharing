class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations, id: :integer do |t|
      t.integer:users_id
      t.date   :dates
      t.time   :times
      t.string :name
    end
  end
end
