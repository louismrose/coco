class InstanceRunner
  @queue = :instances
  def self.perform(instance_id)
    sleep(10)
    instance = Instance.find(instance_id)
    instance.update_attribute(:input_model, instance.input_model.reverse)
  end
end