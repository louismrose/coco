class Transformation < ActiveRecord::Base
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

  def code
"""rule Tree2Node 
  transform t : Tree!Tree
  to n : Graph!Node {
  
  n.name = t.label;
  
  // If t is not the top tree
  // create an edge connecting n
  // with the Node created from t's parent
  if (t.parent.isDefined()) {
    var e : new Graph!Edge;
    e.source ::= t.parent;
    e.target = n;
  }  
}"""
  end
end
