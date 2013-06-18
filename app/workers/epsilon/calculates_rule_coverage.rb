require "java/epsilon.jar"

class CalculatesRuleCoverage
  def initialize(etl_module)
    @etl_module = etl_module
  end
  
  def run
    coverage = {}
    
    # Unset rule coverage for all rules declared in the transformation
    @etl_module.declared_transform_rules.each do |rule|
      coverage[rule.name] = false
    end
    
    # Set rule coverage each time a rule is referenced in the transformation_trace
    @etl_module.context.transformation_trace.transformations.each do |trace_element|
      coverage[trace_element.rule.name] = true
    end
    
    # Convert coverage hash to array of 1s and 0s
    coverage.
      values.
      map { |covered| covered ? 1 : 0 }
  end
end