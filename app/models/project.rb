class Project < ActiveRecord::Base
    validates :name, length: {minimum: 1}, presence: true
    
    has_many :task
end
