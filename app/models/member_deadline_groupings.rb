class MemberDeadlineGroupings < ActiveRecord::Base
    belongs_to :members
    belongs_to :deadlines
end
