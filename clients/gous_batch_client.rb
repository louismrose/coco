require "httparty"

class Evaluator
  def initialize(url)
    @url = url
  end
  
  def run(instances)

    # Exercise the SUT
    results = HTTParty.post(@url, body: { instances: instances } )
    new_instances = results["instances"]
    
    puts results.body
    
    new_instances.each do |new_instance|
      puts "Instantiated SUT, creating instance \##{new_instance["id"]}."
    end
    
    new_instances.each do |new_instance|
      coverage_url = new_instance["coverage_url"]
      puts "Polling for results at: #{coverage_url}"

      # Wait for coverage results
      results = HTTParty.get(coverage_url)
      until results["coverage"] or results["error"] do
        puts "Coverage not yet ready, waiting for 1 second before retrying"
        sleep 1
        results = HTTParty.get(coverage_url)
      end
    
      if results["coverage"]
        puts results["coverage"].to_s  # [0,1,0,...]
      else
        puts "An error was encountered: " + results["error"]
      end
    
    end
  end
end

instances = {
  "1" =>
  {
    symbols: ["@Spec", "{", "MetaModel", "\"Tree\"", "{", "nsUri", "=", "\"Tree\"", "}", "}", "Trees", "{", "Tree", "{", "children:", "Tree", "{", "label:", "\"t2\"", "}", "}", "}"],
    variables: ["S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "S"]
  },
  "2" =>
  {
    symbols: ["@Spec", "{", "MetaModel", "\"Tree\"", "{", "nsUri", "=", "\"Tree\"", "}", "}", "Trees", "{", "Tree", "{", "}", "}"],
    variables: ["S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "[Tree]", "[Tree]", "[Tree]", "S"]
  }
}

Evaluator.new("http://coco.herokuapp.com/transformations/1/instances.batch.gous.json").run(instances)