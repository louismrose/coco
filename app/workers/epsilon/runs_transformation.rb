require "java/epsilon.jar"

class RunsTransformation
  def initialize(transformation, *models)
    @transformation, @models = transformation, models
  end
  
  def run
    transformer = Java::OrgEclipseEpsilonEtl::EtlModule.new
    transformer.parse(@transformation)
    @models.each { |m| transformer.context.modelRepository.addModel(m) }
    transformer.execute
    transformer
  end
end