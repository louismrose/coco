require "java/emf.jar"
require "app/workers/epsilon/creates_empty_model.rb"

describe CreatesEmptyModel, "#run" do
  subject(:model) { CreatesEmptyModel.new("Empty", metamodel).run }
  
  it "creates an empty model" do
    model.allContents.size.should eq(0)
  end
  
  it "creates a model that can be manipulated" do
    model.createInstance("EClass")
    model.allContents.size.should eq(1)
  end
  
  it "creates a model that is named" do
    model.name.should eq("Empty")
  end
  
  
private
  def metamodel
    ecore = Java::OrgEclipseEmfEcore::EcorePackage.eINSTANCE
    register(ecore)
    ecore
  end
  
  def register(package)
    Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.put(package.nsURI, package)
  end
end