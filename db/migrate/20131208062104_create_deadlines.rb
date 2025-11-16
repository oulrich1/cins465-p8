class CreateDeadlines < ActiveRecord::Migration[4.2]
  def change
    create_table :deadlines do |t|
      t.integer :m_id # member who created this deadline
      t.integer :p_id
      t.text :title
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
