require "java/emf.jar"
require "app/workers/epsilon/runs_transformation.rb"

describe RunsTransformation, "#run" do
  it "produces a model after running transformation" do
    RunsTransformation.new(transformation, input_model, output_model).run
    output_model.allContents.size.should eq(1)
    output_model.allContents.get(0).name.should eq("Family".reverse)
  end
  
  def transformation
<<-EOS
rule ReverseClassNames 
  transform s : Source!EClass
  to t : Target!EClass {
  
  t.name = s.name.reverse();
}

operation String reverse() {
  var reversed = "";
  for (char in self.toCharSequence()) {
    reversed = char + reversed;
  }
  return reversed;
}
EOS
  end
  
  def input_model
    @input_model ||= create_ecore_model("Source").tap do |m|
      m.createInstance("EClass").name = "Family"
    end
  end

  def output_model
    @output_model ||= create_ecore_model("Target")
  end
  
  def create_ecore_model(name)
    Java::OrgEclipseEpsilonEmcEmf::InMemoryEmfModel.new(name, resource, ecore)
  end
  
  def resource
    Java::OrgEclipseEpsilonEmcEmf::EmfUtil.createResource
  end
  
  def ecore
    Java::OrgEclipseEmfEcore::EcorePackage.eINSTANCE
  end
end