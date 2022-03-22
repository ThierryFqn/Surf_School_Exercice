class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :teacher, :boolean, default: false
    add_column :users, :username, :string
  end
end
