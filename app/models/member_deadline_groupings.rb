class MemberDeadlineGroupings < ApplicationRecord
  belongs_to :member, foreign_key: 'm_id', optional: true
  belongs_to :deadline, foreign_key: 'd_id', optional: true
end
