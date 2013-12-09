class CreateMemberProjectGroupings < ActiveRecord::Migration
  def change
    create_table :member_project_groupings do |t|
        t.references :members, index: true
      t.references :projects, index: true
      t.integer :m_id
      t.integer :p_id

      t.timestamps
    end
  end
end
