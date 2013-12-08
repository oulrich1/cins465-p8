class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.references :members, index: true
      t.references :projects, index: true
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
