class CreateLogins < ActiveRecord::Migration[6.1]
  def change
    create_table :logins, id: :integer do |t|
      t.integer:users_id
      t.string :password
    end
  end
end
