require "java/emf.jar"
require "app/workers/instance_runner.rb"

describe InstanceRunner, "#transform" do
  subject(:runner) { InstanceRunner.new(instance) }
  
  it "should produce the right number of nodes" do
    runner.transform
    nodes = runner.output_model.getAllOfType("Node")
    nodes.size.should eq(2)
  end
  
  it "should produce the right number of edges" do
    runner.transform
    edges = runner.output_model.getAllOfType("Edge")
    edges.size.should eq(1)
  end
  
  it "should update instance's output model" do
    runner.transform
    instance.output_model.should eq(expected_output_hutn)
  end
  
  it "should update instance's coverage" do
    runner.transform
    instance.coverage.should eq("1")
  end

  def instance
    @instance ||= Instance.new
  end
  
  def expected_output_hutn
<<-EOS
@Spec {
	metamodel "Graph" {
		nsUri: "Graph"
	}
}

package  {
	Node "Node1" {
		outgoing: Edge "Edge1" {
			target: Node "t2"
		}
	}
	Node "t2" {
		name: "t2"
		incoming: Edge "Edge1"
	}
}
EOS
  end
  
  class Instance
    attr_accessor :output_model, :coverage
    
    def input_model
<<-EOS
  @Spec {
  	MetaModel "Tree" {
  		nsUri = "Tree"
  	}
  }
  Trees {
  	Tree {
  		children: Tree { label: "t2" }
  	}
  }
EOS
    end
    
    def transformation
      Transformation.new
    end
    
    class Transformation
     def code
  <<-EOS
  rule Tree2Node 
  	transform t : Tree!Tree
  	to n : Graph!Node {

  	n.name := t.label;
  	if (t.parent.isDefined()) {
  		var e : new Graph!Edge;
  		e.source ::= t.parent;
  		e.target := n;
  	}	
  }
  EOS
      end

      def source_metamodel
  <<-EOS
  @namespace(uri="Tree", prefix="Tree")
  package Tree;

  class Tree {
     val Tree[*]#parent children;
     ref Tree#children parent;
     attr String label;
  }
  EOS
      end

      def target_metamodel
  <<-EOS
  @namespace(uri="Graph", prefix="Graph")
  package Graph;

  class Graph {
     val Node[*] nodes;
  }

  class Node {
     attr String name;
     val Edge[*]#source outgoing;
     ref Edge[*]#target incoming;
  }

  class Edge {
     ref Node#outgoing source;
     ref Node#incoming target;
  }
  EOS
      end
    end
  end
end