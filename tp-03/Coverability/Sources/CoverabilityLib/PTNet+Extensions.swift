import PetriKit

public extension PTNet {

    // Marquage tirable créé

    public func Conversion (with marking : CoverabilityMarking, and y : [PTPlace]) -> PTMarking{
      var x : PTMarking = [:]

      for temp in y
      {
        let z = Gvl(to : marking[temp]!)!
        x[temp] = z}
      return x  }

    // retour au marquage de couverture

    public func Deconversion(with marking: PTMarking, and y : [PTPlace]) ->CoverabilityMarking{
      var temp : CoverabilityMarking = [:]
      for V in y
      {
        temp[V] = .some(marking[V]!)
           if(500 < temp[V]!)
           {
             temp[V] = .omega }}
         return temp }

    // Error Check

    public func Gvl(to x: Token) -> UInt? {
      if case .some(let vlr) = x {
        return vlr
      }
      else {
        return 1000  }}

    // Node Check (list)
    public func Check(at marking : [CoverabilityMarking], to markingToAdd : CoverabilityMarking) -> Int
    {
      var vlr = 0
      for i in 0...marking.count-1
      {
        if (marking[i] == markingToAdd) {
          vlr = 1 }
        if (markingToAdd > marking[i]) {
          vlr = i+2}}
      return vlr }

    //Permet d'introduire le Omega
    public func Omega(from comp : CoverabilityMarking, with marking : CoverabilityMarking, and y : [PTPlace])  -> CoverabilityMarking?
    {
      var temp = marking
      for x in y {
        if (comp[x]! < temp[x]!){
          temp[x] = .omega }}
      return temp }


    public func coverabilityGraph(from marking0: CoverabilityMarking) -> CoverabilityGraph? {

        // Créer array avec Places et Transitions

        var Trans = Array (transitions)
        Trans.sort{$0.name < $1.name}
        let Rgraph = CoverabilityGraph(marking: marking0, successors: [:])
        let Plc = Array(places)
        var graphList : [CoverabilityGraph] = []
        var z: CoverabilityMarking
        var ListMark : [CoverabilityMarking] = [marking0]
        var count = 0
        while(count < ListMark.count)
        {

          for tran in Trans{
            let ptMarking = Conversion(with: ListMark[count], and: Plc)
            if let firedTran = tran.fire(from: ptMarking){
              let convMarking = Deconversion(with: firedTran, and: Plc)
              let nouvCouv = CoverabilityGraph(marking: convMarking, successors: [:])
              Rgraph.successors[tran] = nouvCouv }

            if(Rgraph.successors[tran] != nil){
              // on ajoute son marquage à la variable z
              z = Rgraph.successors[tran]!.marking
              // On vérifie si il est contenu dans la liste
              let current = Check(at: ListMark, to: z)
              if (current != 1) {
                if (current > 1) {
                  z = Omega(from : ListMark[current-2], with : z, and : Plc)! }
                graphList.append(Rgraph)
                ListMark.append(z)
              }}}
          count = count + 1  }
  return Rgraph
      }
}
