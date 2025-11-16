class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.string      :name, :null => false, :default => ""
      t.string      :url, :null => false, :default => "#"
      t.datetime    :expected_due_date
      t.references  :manager, index: true

      t.timestamps
    end
  end
end
