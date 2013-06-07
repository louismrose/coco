require "java/emf.jar"

class RegistersMetamodelFromXmi
  def initialize(xmi)
    @xmi = xmi
  end
  
  def run
    package = resource.contents.get(0)
    register_package(package)
    package
  end
  
private
  def resource
    resource = Java::OrgEclipseEmfEcoreXmiImpl::XMIResourceImpl.new
    resource.load(Java::JavaIo::ByteArrayInputStream.new(@xmi.to_java_bytes), nil)  
    resource
  end
  
  def register_package(package)
    Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.put(package.nsURI, package)
  end
end