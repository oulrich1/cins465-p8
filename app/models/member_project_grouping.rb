class MemberProjectGrouping < ApplicationRecord
  belongs_to :member, foreign_key: 'm_id', optional: true
  belongs_to :project, foreign_key: 'p_id', optional: true
end
