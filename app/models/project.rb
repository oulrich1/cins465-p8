class Project < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true

    belongs_to :manager
    has_many :member_project_groupings , :foreign_key => 'p_id'
    has_many :members, :through => :member_project_groupings

    has_many :deadlines , :foreign_key => 'p_id'
    has_many :members, :through => :deadlines
end
