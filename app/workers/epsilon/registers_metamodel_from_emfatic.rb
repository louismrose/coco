require "java/emf.jar"
require "java/emfatic.jar"

class RegistersMetamodelFromEmfatic
  def initialize(emfatic)
    @emfatic = emfatic
  end
  
  def run
    context = parse
    builder = build(context)
    connect(context, builder)
    
    package = resource.contents.get(0)
    register_package(package)
    package
  end
  
private
  def parse
    parser = Java::OrgEclipseEmfEmfaticCoreLangGenParser::EmfaticParserDriver.new
    stream = Java::JavaIo::ByteArrayInputStream.new(@emfatic.to_java_bytes)
    parser.parse(Java::JavaIo::BufferedReader.new(Java::JavaIo::InputStreamReader.new(stream)))
  end
  
  def build(context)
    builder = Java::OrgEclipseEmfEmfaticCoreGeneratorEcore::Builder.new
    builder.build(context, resource, nil)
    builder
  end
  
  def connect(context, builder)
    connector = Java::OrgEclipseEmfEmfaticCoreGeneratorEcore::Connector.new(builder)
		connector.connect(context, resource, nil)
  end
  
  def register_package(package)
    Java::OrgEclipseEmfEcore::EPackage::Registry.INSTANCE.put(package.nsURI, package)
  end
  
  # FIXME The following methods are duplicated across other classes in this directory...
  
  def resource
    @resource ||= resource_set.createResource(uri)
  end
  
  def resource_set
    resource_set = Java::OrgEclipseEmfEcoreResourceImpl::ResourceSetImpl.new
    resource_set.resourceFactoryRegistry.extensionToFactoryMap.put("*", resource_factory)
    resource_set
  end
  
  def resource_factory
    Java::OrgEclipseEmfEcoreXmiImpl::EcoreResourceFactoryImpl.new
  end
  
  def uri
    Java::OrgEclipseEmfCommonUtil::URI.createFileURI("MM.ecore")
  end
end