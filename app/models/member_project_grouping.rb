class MemberProjectGrouping < ActiveRecord::Base
    belongs_to :members
    belongs_to :projects
end
