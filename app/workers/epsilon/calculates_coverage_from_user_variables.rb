require "java/epsilon.jar"

class CalculatesCoverageFromUserVariables
  attr_reader :etl_module, :variable_name
  
  def initialize(etl_module, variable_name)
    @etl_module, @variable_name = etl_module, variable_name
  end
  
  def run
    coverage_hash = value_of_variable(variable_name, {})
    puts coverage_hash
    coverage_hash.values
  end

private
  def value_of_variable(variable_name, default)
    variable = etl_module.context.frame_stack.get(variable_name)
    if variable then variable.value else default end
  end
end