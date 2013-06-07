require "java/epsilon.jar"

class LoadsModelFromHutn
  def initialize(name, hutn)
    @name, @hutn = name, hutn
  end
  
  def run
    m = Java::OrgEclipseEpsilonEmcHutn::HutnModel.new(@name, @hutn)
    m.load
    m
  end
end