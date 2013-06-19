require "httparty"

class Evaluator
  def initialize(url)
    @url = url
  end
  
  def run(symbols, variables)

    # Exercise the SUT
    new_instance = HTTParty.post(@url, body: { symbols: symbols, variables: variables } )
    coverage_url = new_instance["coverage_url"]
    puts "Instantiated SUT, creating instance \##{new_instance["id"]}."
    puts "Polling for results at: #{coverage_url}"


    # Wait for coverage results
    results = HTTParty.get(coverage_url)
    until results["coverage"] do
      puts "Coverage not yet ready, waiting for 1 second before retrying"
      sleep 1
      results = HTTParty.get(coverage_url)
    end

    puts results["coverage"].to_s  # [0,1,0,...]
  end
end

symbols = ["@Spec", "{", "MetaModel", "\"Tree\"", "{", "nsUri", "=", "\"Tree\"", "}", "}", "Trees", "{", "Tree", "{", "children:", "Tree", "{", "label:", "\"t2\"", "}", "}", "}"]
variables = ["S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "[Tree]", "S"]

Evaluator.new("http://coco.herokuapp.com/transformations/1/instances.gous.json").run(symbols, variables)