require "transformers/reverser.jar"

class InstanceRunner
  @queue = :instances
  def self.perform(instance_id)
    sleep(10)
    instance = Instance.find(instance_id)
    instance.update_attribute(:input_model, reverse(instance.input_model))
  end
  
  def self.reverse(subject)
    Java::String::Reverser.new(subject).run
  end
end