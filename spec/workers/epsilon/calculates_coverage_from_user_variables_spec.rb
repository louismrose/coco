require "app/workers/epsilon/calculates_coverage_from_user_variables.rb"

describe CalculatesCoverageFromUserVariables, "#run" do
  it "calculates coverage from name variable" do
    coverage = CalculatesCoverageFromUserVariables.new(etl_module("branch_coverage"), "branch_coverage").run
    coverage.should eq([1, 0])
  end
  
  it "returns an empty array when variable does not exist" do
    coverage = CalculatesCoverageFromUserVariables.new(etl_module("branch_coverage"), "doesnt_exist").run
    coverage.should eq([])
  end
  
  def etl_module(variable_name)
    fake = Object.new
    fake.stub_chain(:context, :frame_stack).and_return(etl_frame_stack(variable_name))
    fake
  end
  
  def etl_frame_stack(variable_name)
    fake = Object.new
    fake.stub(:get) do |arg|
      if arg == variable_name
        etl_variable
      else
        nil
      end
    end
    fake
  end
  
  def etl_variable
    fake = Object.new
    fake.stub(:value).and_return({ "branch1" => 1, "branch2" => 0 })
    fake
  end
end