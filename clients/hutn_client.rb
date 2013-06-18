require "httparty"

class Evaluator
  def initialize(url)
    @url = url
  end
  
  def run(hutn)

    # Exercise the SUT
    new_instance = HTTParty.post(@url, body: { instance: { input_model: hutn } } )
  
    id = new_instance["id"]
    coverage_url = @url.chomp(".json") + "/#{id}.json"
    
    puts "Instantiated SUT, creating instance \##{id}."
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

hutn = File.read(File.join(File.dirname(__FILE__), "wildebeest.hutn"))
Evaluator.new("http://localhost:2000/transformations/2/instances.json").run(hutn)




