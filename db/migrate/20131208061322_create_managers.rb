class CreateManagers < ActiveRecord::Migration[4.2]
  def change
    create_table :managers do |t|
      t.string :name
      t.string :email
      t.string :type

      t.timestamps
    end
  end
end
