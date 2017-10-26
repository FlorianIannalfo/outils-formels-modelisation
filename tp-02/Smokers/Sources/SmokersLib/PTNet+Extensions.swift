mport PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {
//--------------------------------------------------------------------------------------------------------------------------------------------------
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
    }
          return M0  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//Nombres d'états possibles :

    public func StatesN(input:MarkingGraph) -> Int{

      var Discovered: [MarkingGraph] = []
      var UnDiscovered: [MarkingGraph] = [input]

      while let PresValue = UnDiscovered.popLast(){
          Discovered.append(PresValue)
          for (_, successor) in PresValue.successors{
               if !Discovered.contains(where: {$0 === successor}) && !UnDiscovered.contains(where: {$0 === successor}){
               UnDiscovered.append(successor)  }}}
      return Discovered.count
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------
//Plus que deux fumeurs en même temps ? :

    public func TwoSmk (imput: MarkingGraph) -> Bool {

      var Discovered = [MarkingGraph]()
      var Undiscovered = [MarkingGraph]()

      Undiscovered.append(imput)
      while let PresValue = Undiscovered.popLast() {
        Discovered.append(PresValue)
        var n = 0;
        for (key, value) in PresValue.marking {
               if (key.name == "s1" || key.name == "s2" || key.name == "s3"){
               n += Int(value)}}
               if (n > 1) {print (PresValue.marking)
               return true}
        for(_, successor) in PresValue.successors{
              if !Discovered.contains(where: {$0 === successor}) && !Undiscovered.contains(where: {$0 === successor}){
              Undiscovered.append(successor) }}}
        return false
        }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------
//Deux ingéredient similaire sur la table ? :

public func DuplicateObj(input:MarkingGraph) -> Bool{

     var Discovered: [MarkingGraph] = []
     var Undiscovered: [MarkingGraph] = [input]

     while let PresValue = Undiscovered.popLast(){
         Discovered.append(PresValue)
            for (place, tkn) in PresValue.marking{
              if place.name == "p" || place.name == "m" || place.name == "t"{
                if(tkn > 1){
                return true }}
                }
    for (_, successor) in PresValue.successors{
           if !Discovered.contains(where: {$0 === successor}) && !Undiscovered.contains(where: {$0 === successor}){
              Undiscovered.append(successor) }}}
    return false
    }}
