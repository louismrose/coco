require "java/epsilon.jar"

class SerialisesModelToHutn
  def initialize(m)
    @model = m
  end
  
  def run
    convert_to_hutn xmi
  end
  
private
  def xmi
    stream = Java::JavaIo::ByteArrayOutputStream.new
    @model.modelImpl.save(stream, nil)
    stream.to_s
  end
  
  def convert_to_hutn(xmi)
    Java::org.eclipse.epsilon.hutn.xmi::Xmi2Hutn.new(xmi).hutn
  end
end
