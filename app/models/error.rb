class Error
  def self.all_for(transformation_id)
    condition = 'transformation_id = ? AND error IS NOT NULL'

    Instance.select(:error).uniq.where(condition, transformation_id).map do |i|
      Error.new(i.error)
    end
  end
  
  attr_reader :message
  
  def initialize(message)
    @message = message
  end
  
  def instances
    Instance.where(error: @message)
  end
end