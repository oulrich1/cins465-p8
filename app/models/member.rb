class Member < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    has_many :member_project_groupings, :foreign_key => 'm_id'
    has_many :projects, :through => :member_project_groupings

    has_many :deadlines, :foreign_key => 'm_id'
    has_many :projects, :through => :deadlines
end


