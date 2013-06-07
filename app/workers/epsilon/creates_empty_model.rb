require "java/epsilon.jar"

class CreatesEmptyModel
  def initialize(name, metamodel)
    @name, @metamodel = name, metamodel
  end
  
  def run
    Java::OrgEclipseEpsilonEmcEmf::InMemoryEmfModel.new(@name, resource, @metamodel)
  end

private
  def resource
    resource_set.createResource(uri)
  end
  
  def resource_set
    resource_set = Java::OrgEclipseEmfEcoreResourceImpl::ResourceSetImpl.new
    resource_set.resourceFactoryRegistry.extensionToFactoryMap.put("*", resource_factory)
    resource_set
  end
  
  def resource_factory
    Java::OrgEclipseEmfEcoreXmiImpl::XMIResourceFactoryImpl.new
  end
  
  def uri
    Java::OrgEclipseEmfCommonUtil::URI.createFileURI(@name + ".xmi")
  end
end
