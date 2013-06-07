require "epsilon/registers_metamodel"

class InstanceRunner
  @queue = :instances
  
  def self.perform(instance_id)
    instance = Instance.find(instance_id)
    instance.update_attribute(:output_model, transform(instance))
  end
  
  def self.transform(instance)
    register_metamodels([instance.source_metamodel, instance.target_metamodel])
    input_model = load_model_from_hutn(instance.input_model)
    output_model = run_transformation(instance.transformation, input_model)
    serialise(output_model)
  end
  
  def self.register_metamodels(metamodels)
    metamodels.each {|m| register_metamodel(m) }
  end
  
  def self.register_metamodel(metamodel)  
    RegistersMetamodel.new(metamodel).run
  end
  
  def load_model_from_hutn(model)
    nil
  end
  
  def run_transformation(transformation, input_model)
    nil
  end
  
  def serialise(model)
    ""
  end
end

# // Register MMs
# EPackage.Registry.INSTANCE.put(WildebeestPackage.eNS_URI, WildebeestPackage.eINSTANCE);
# EPackage.Registry.INSTANCE.put(OctopusPackage.eNS_URI, OctopusPackage.eINSTANCE);
# 
# 
# // Create model from HUTN input
# log("Parsing HUTN");
# final HutnModule hutn = new HutnModule();
# hutn.parse(inputHutn);
# 
# if (!hutn.getParseProblems().isEmpty()) {
#   return "Error encountered whilst parsing HUTN: " + hutn.getParseProblems() + " Input was: " + inputHutn;
# }
# 
# final EmfModel intermediate = new InMemoryEmfModel("Intermediate", hutn.getIntermediateModel().eResource(), HutnPackage.eINSTANCE);
# final EmfModel source = new InMemoryEmfModel("Model", EmfUtil.createResource(), WildebeestPackage.eINSTANCE);
# 
# // Run intermediate2wildebeest transformation
# log("Running HUTN-to-model transformation");
# final EtlModule inputTransformer = new EtlModule();
# inputTransformer.parse(intermediate2modelTransformation());
# 
# for (ParseProblem problem : inputTransformer.getParseProblems()) {
#   System.out.println("Error: " + problem);
# }
# 
# inputTransformer.getContext().getModelRepository().addModel(intermediate);
# inputTransformer.getContext().getModelRepository().addModel(source);
# inputTransformer.execute();
# 
# 
# // Run transformation that is actually covered
# log("Running transformation-under-test");
# source.setName("Wildebeest");
# final EmfModel target = new InMemoryEmfModel("Octopus", EmfUtil.createResource(), OctopusPackage.eINSTANCE);
# 
# final EtlModule transformer = new EtlModule();
# 
# final CoverageExecutionListener listener = new CoverageExecutionListener();
# listener.addCoverageStrategy(new EtlRuleCoverageStrategy());
# transformer.getContext().getExecutorFactory().addExecutionListener(listener);
# 
# transformer.parse(transformation());
# transformer.getContext().getModelRepository().addModel(source);
# transformer.getContext().getModelRepository().addModel(target);
# transformer.getContext().getFrameStack().putGlobal(Variable.createReadOnlyVariable("expectedCoveragePercentage", expectedProportionCoverage));
# 
# for (ParseProblem problem : transformer.getParseProblems()) {
#   System.out.println("Error: " + problem);
# }
# 
# transformer.execute();
# 
# 
# // Calculate coverage
# log("Calculating coverage from transformation context");
# SortedMap<String, Integer> coverage = new TreeMap<String, Integer>();
# 
# calculateRuleCoverage(transformer, coverage);
# calculateBranchCoverage(transformer, coverage);
# calculateConditionCoverage(transformer, coverage);
# calculateProportionCoverage(transformer, coverage);
#  
# 
# // Return coverage elements as a space delimited bitstring
# log("Building bitstring");
# String bitstring = "";
# int index = 0;    
# 
# for (Map.Entry<String, Integer> coverageElement : coverage.entrySet()) {
#   if ("Area2Zone".equals(coverageElement.getKey())) {
#     bitstring += coverageElement.getValue() < 3 ? "0" : "1";
#   } else {
#     bitstring += coverageElement.getValue() == 0 ? "0" : "1";
#   }
#   
#   if (index < coverage.size() - 1)
#     bitstring += " ";
#   
#   index++;
# }
# 
# // Clean-up
# log("Cleaning up");
# inputTransformer.getContext().dispose();
# transformer.getContext().dispose();
# source.disposeModel();
# target.disposeModel();
# intermediate.disposeModel();
# 
# 
# return bitstring;