require_relative "epsilon/registers_metamodel_from_emfatic"
require_relative "epsilon/loads_model_from_hutn"
require_relative "epsilon/creates_empty_model"
require_relative "epsilon/runs_transformation"
require_relative "epsilon/serialises_model_to_hutn"

class InstanceRunner
  @queue = :instances
  
  def self.perform(instance_id)
    instance = Instance.find(instance_id)
    instance.update_attribute(:output_model, InstanceRunner.new(instance).transform)
  end
  
  def initialize(instance)
    @instance = instance
    @source_metamodel = register_metamodel(@instance.transformation.source_metamodel)
    @target_metamodel = register_metamodel(@instance.transformation.target_metamodel)
  end
  
  def transform
    run_transformation
    serialise output_model
  end
  
  def register_metamodel(metamodel)  
    RegistersMetamodelFromEmfatic.new(metamodel).run
  end
  
  def input_model
    @input_model ||= LoadsModelFromHutn.new("Tree", @instance.input_model).run
  end
  
  def output_model
    @output_model ||= CreatesEmptyModel.new("Graph", @target_metamodel).run
  end
  
  def run_transformation
    RunsTransformation.new(@instance.transformation.code, input_model, output_model).run
  end
  
  def serialise(model_to_serialise)
    SerialisesModelToHutn.new(model_to_serialise).run
  end
end