class CreateMemberDeadlineGroupings < ActiveRecord::Migration
  def change
    create_table :member_deadline_groupings do |t|
      t.integer :m_id
      t.integer :d_id

      t.timestamps
    end
  end
end
