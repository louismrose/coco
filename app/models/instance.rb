class Instance < ActiveRecord::Base
  belongs_to :transformation
  serialize :coverage, JSON # stored as an Array in the database
end
