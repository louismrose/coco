require "app/workers/epsilon/loads_model_from_hutn.rb"

describe LoadsModelFromHutn, "#run" do
  subject(:model) { LoadsModelFromHutn.new("TheSmiths", hutn).run }
  
  it "loads a model from valid HUTN" do
    first_element = model.allContents.first
    first_element.name.should eq("families")
  end
  
  it "loads a model with given name" do
    model.name.should eq("TheSmiths")
  end
  
  it "errors on invalid HUTN" do
    expect { LoadsModelFromHutn.new("this is invalid HUTN").run }.to raise_error
  end
  
  def hutn
<<-EOS
@Spec {
	MetaModel "Ecore" {
		nsUri = "http://www.eclipse.org/emf/2002/Ecore"
	}
}
Ecore {
	EPackage {
		name: "families"
	}
}
EOS
  end
end