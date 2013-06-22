class Transformation < ActiveRecord::Base
  has_many :instances
  validates_presence_of :name

  def self.find_by_id_or_name(id_or_name)
    if exists?(name: id_or_name)
      where(name: id_or_name).first
    else
      find(id_or_name)
    end
  end
  
  def grammar_file
    "db/transformation_seeds/#{id}/source.gous.xml"
  end
end
