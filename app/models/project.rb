class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :manager, optional: true
  has_many :member_project_groupings, foreign_key: 'p_id', dependent: :destroy
  has_many :members, through: :member_project_groupings

  # has_many :deadlines, foreign_key: 'p_id'
  # has_many :members, through: :deadlines

  has_many :deadlines, foreign_key: 'p_id', dependent: :destroy
end
