class Member < ActiveRecord::Base

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :confirmable, :validatable


    has_many :deadlines
    has_many :projects, :through => :deadlines
end
