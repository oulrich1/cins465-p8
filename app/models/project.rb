class Project < ActiveRecord::Base
  belongs_to :manager
  has_many :deadlines
  has_many :members, :through => :deadlines
end
