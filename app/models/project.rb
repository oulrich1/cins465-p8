class Project < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true

    belongs_to :manager
    has_many :deadlines , :foreign_key => 'p_id'
    has_many :members, :through => :deadlines
end
