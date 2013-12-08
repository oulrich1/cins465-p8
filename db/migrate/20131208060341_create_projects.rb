class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.datetime :expected_due_date
      t.references :manager, index: true

      t.timestamps
    end
  end
end
