class Deadline < ActiveRecord::Base
    belongs_to :projects

    has_many :member_deadline_groupings , :foreign_key => 'd_id'
    has_many :members, :through => :member_deadline_groupings
end
