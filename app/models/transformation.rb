class Transformation < ActiveRecord::Base
  has_many :instances
  
  def grammar_file
    "db/transformation_seeds/#{id}/source.gous.xml"
  end
end
