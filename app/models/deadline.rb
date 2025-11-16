class Deadline < ApplicationRecord
  belongs_to :project, foreign_key: 'p_id', optional: true

  has_many :member_deadline_groupings, foreign_key: 'd_id', dependent: :destroy
  has_many :members, through: :member_deadline_groupings
end
