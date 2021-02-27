class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :integer do |t|
      t.string :initial_name
      t.string :actual_name
    end
  end
end
