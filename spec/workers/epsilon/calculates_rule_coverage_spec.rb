require "app/workers/epsilon/calculates_rule_coverage.rb"

describe CalculatesRuleCoverage, "#run" do
  it "calculates accurate rule coverage" do
    coverage = CalculatesRuleCoverage.new(etl_module).run
    coverage.should eq([1, 0])
  end
  
  def etl_module
    fake = Object.new
    fake.stub(:declared_transform_rules).and_return(etl_rules)
    fake.stub_chain(:context, :transformation_trace, :transformations).and_return(etl_trace_elements)
    fake
  end
  
  def etl_rules
    [etl_rule("Family2Address"), etl_rule("Person2Contact")]
  end
  
  def etl_trace_elements
    [etl_trace_element("Family2Address"), etl_trace_element("Family2Address")]
  end
  
  def etl_rule(name)
    fake = Object.new
    fake.stub(:name).and_return(name)
    fake
  end
  
  def etl_trace_element(rule_name)
    fake = Object.new
    fake.stub_chain(:rule, :name).and_return(rule_name)
    fake
  end
end