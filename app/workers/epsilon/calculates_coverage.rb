require "java/epsilon.jar"

class CalculatesCoverage
  def initialize(etl_module)
    @etl_module = etl_module
  end
  
  def run
    calculate_rule_coverage
  end
  
  def calculate_rule_coverage
    coverage = {}
    
    # Unset rule coverage for all rules declared in the transformation
    @etl_module.declared_transform_rules.each do |rule|
      coverage[rule.name] = false
    end
    
    # Set rule coverage each time a rule is referenced in the transformation_trace
    @etl_module.context.transformation_trace.transformations.each do |trace_element|
      coverage[trace_element.rule.name] = true
    end
    
    # Convert coverage hash to space-separated bitstring
    coverage.
      values.
      map { |covered| covered ? 1 : 0 }.
      join(' ')
  end
end