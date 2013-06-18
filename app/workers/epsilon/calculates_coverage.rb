require_relative "calculates_rule_coverage"
require_relative "calculates_coverage_from_user_variables"

class CalculatesCoverage
  attr_reader :etl_module
  
  def initialize(etl_module)
    @etl_module = etl_module
  end
  
  def run
    delegates.map(&:run).flatten
  end

private
  def delegates
    [
      CalculatesRuleCoverage.new(etl_module),
      CalculatesCoverageFromUserVariables.new(etl_module, 'branch_coverage'),
      CalculatesCoverageFromUserVariables.new(etl_module, 'condition_coverage'),
      CalculatesCoverageFromUserVariables.new(etl_module, 'proportion_coverage')
    ]
  end
end