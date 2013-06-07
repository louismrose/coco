require "java/emf.jar"
require "app/workers/epsilon/serialises_model_to_hutn.rb"

describe SerialisesModelToHutn, "#run" do
  it "serialises to HUTN" do
    hutn = SerialisesModelToHutn.new(model).run
    hutn.should eq(expected)
  end
  
private
  def expected
<<-EOS
@Spec {
	metamodel "http://www.eclipse.org/emf/2002/Ecore" {
		nsUri: "http://www.eclipse.org/emf/2002/Ecore"
	}
}

package  {
	EClass "Family" {
		name: "Family"
	}
	EClass "Person" {
		name: "Person"
	}
}
EOS
  end

  def model
    @model ||= create_ecore_model("Families").tap do |m|
      m.createInstance("EClass").name = "Family"
      m.createInstance("EClass").name = "Person"
    end
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