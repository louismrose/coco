require "app/workers/epsilon/registers_metamodel.rb"

describe RegistersMetamodel, "#run" do
  it "registers valid XMI" do
    RegistersMetamodel.new(families_xmi).run
    p = Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.get("http://families")
    p.name.should eq("families")
  end
  
  it "errors on invalid XMI" do
    expect { RegistersMetamodel.new("this is invalid XMI").run }.to raise_error
  end
  
  def families_xmi
<<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<ecore:EPackage xmi:version="2.0"
    xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ecore="http://www.eclipse.org/emf/2002/Ecore" name="families"
    nsURI="http://families" nsPrefix="fam">
  <eClassifiers xsi:type="ecore:EClass" name="Family">
    <eStructuralFeatures xsi:type="ecore:EAttribute" name="name" eType="ecore:EDataType http://www.eclipse.org/emf/2002/Ecore#//EString"/>
  </eClassifiers>
</ecore:EPackage>
EOS
  end
end