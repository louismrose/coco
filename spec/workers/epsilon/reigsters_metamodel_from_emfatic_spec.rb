require "app/workers/epsilon/registers_metamodel_from_emfatic.rb"

describe RegistersMetamodelFromEmfatic, "#run" do
  it "registers valid Emfatic" do
    RegistersMetamodelFromEmfatic.new(families_emfatic).run
    p = Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.get("http://families")
    p.name.should eq("families")
  end
  
  it "errors on invalid Emfatic" do
    expect { RegistersMetamodel.new("this is invalid Emfatic").run }.to raise_error
  end
  
  def families_emfatic
<<-EOS
@namespace(uri="http://families", prefix="fam")
package families;

class Family {
  attr String name;
}
EOS
  end
end