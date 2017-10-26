import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {

      var Undiscoveredn = [MarkingGraph]()
      var discoveredn = [MarkingGraph]()
      let M0 = MarkingGraph(marking: marking)
      let transitions = self.transitions

      
      Undiscoveredn.append(M0)
      while(!Undiscoveredn.isEmpty) {
          let thisN = Undiscoveredn.remove(at:0)
          discoveredn.append(thisN)
          for y in transitions {
              if let newMarking = y.fire(from: thisN.marking) {
                      if let seen = discoveredn.first(where: { $0.marking == newMarking }) {
                      thisN.successors[y] = seen }
                      else {
                          let discoveredNode = MarkingGraph(marking: newMarking)
                          thisN.successors[y] = discoveredNode
                          if (!Undiscoveredn.contains(where: { $0.marking == discoveredNode.marking})) {
                          Undiscoveredn.append(discoveredNode)
                          }}}}}
    for x in discoveredn {
          print(x.marking)}
          return M0  }}
