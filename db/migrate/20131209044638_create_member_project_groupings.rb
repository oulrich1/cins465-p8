class CreateMemberProjectGroupings < ActiveRecord::Migration[4.2]
  def change
    create_table :member_project_groupings do |t|
        t.integer :m_id
        t.integer :p_id


        t.timestamps
    end
  end
end
