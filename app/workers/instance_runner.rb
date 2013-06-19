require_relative "epsilon/registers_metamodel_from_emfatic"
require_relative "epsilon/loads_model_from_hutn"
require_relative "epsilon/creates_empty_model"
require_relative "epsilon/runs_transformation"
require_relative "epsilon/serialises_model_to_hutn"
require_relative "epsilon/calculates_coverage"

class InstanceRunner
  @queue = :instances
  
  def self.perform(instance_id)
    instance = Instance.find(instance_id)
    InstanceRunner.new(instance).transform  
    instance.save
  end
  
  def initialize(instance)
    @instance = instance
    @source_metamodel = register_metamodel(@instance.transformation.source_metamodel)
    @target_metamodel = register_metamodel(@instance.transformation.target_metamodel)
  end
  
  def transform
    begin
      run_transformation
      @instance.output_model = serialise(output_model)
      @instance.coverage = calculate_coverage.join(' ')
    rescue java.lang.Throwable => e
      @instance.error = "#{e.class} : #{e.message} caused by: #{e.backtrace.join('\n')}"
    end
  end
  
  def register_metamodel(metamodel)  
    RegistersMetamodelFromEmfatic.new(metamodel).run
  end
  
  def input_model
    @input_model ||= LoadsModelFromHutn.new(@instance.transformation.source_model_name, @instance.input_model).run
  end
  
  def output_model
    @output_model ||= CreatesEmptyModel.new(@instance.transformation.target_model_name, @target_metamodel).run
  end
  
  def run_transformation
    @etl_module = RunsTransformation.new(@instance.transformation.code, input_model, output_model).run
  end
  
  def serialise(model_to_serialise)
    SerialisesModelToHutn.new(model_to_serialise).run
  end
  
  def calculate_coverage
    CalculatesCoverage.new(@etl_module).run
  end
end