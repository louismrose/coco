require "transformers/org.eclipse.emf.common_2.8.0.v20130125-0546.jar"
require "transformers/org.eclipse.emf.ecore_2.8.3.v20130125-0546.jar"
require "transformers/org.eclipse.emf.ecore.xmi_2.8.1.v20130125-0546.jar"

class RegistersMetamodel
  
  def initialize(xmi)
    @xmi = xmi
  end
  
  def run 
    package = resource.getContents().get(0)
    register_package(package)
  end
  
private
  def resource
    resource = Java::OrgEclipseEmfEcoreXmiImpl::XMIResourceImpl.new
    resource.load(Java::JavaIo::ByteArrayInputStream.new(@xmi.to_java_bytes), nil)  
    resource
  end
  
  def register_package(package)
    Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.put(package.getNsURI(), package)
  end
end