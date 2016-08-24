class Task < ActiveRecord::Base
validates :name, length: {minimum: 1}, presence: true

belongs_to :project

default_scope { order("priority ASC") }

end
