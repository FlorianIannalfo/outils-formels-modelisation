import PetriKit
import CoverabilityLib


print("Tp 3 : ")
//TEST
print("createBoundedModel test")


do{
  let model = createBoundedModel()
  guard let s1 = model.places.first(where: { $0.name == "s1" }),
        let s2 = model.places.first(where: { $0.name == "s2" }),
        let s3 = model.places.first(where: { $0.name == "s3" }),
        let t  = model.places.first(where: { $0.name == "t"  }),
        let r = model.places.first(where: { $0.name == "r" }),
        let m  = model.places.first(where: { $0.name == "m"  }),
        let p = model.places.first(where: { $0.name == "p" }),
        let w1  = model.places.first(where: { $0.name == "w1"  }),
        let w2  = model.places.first(where: { $0.name == "w2"  }),
        let w3  = model.places.first(where: { $0.name == "w3"  })
        else {
          fatalError("")
        }

  let initialMarking: CoverabilityMarking =

      [s1: 0, s2: 0, s3: 0, t: 0, r: 1, m: 0, p: 1, w1: 1, w2: 1, w3: 1]

     print("TEST")
  if model.coverabilityGraph(from: initialMarking) != nil{
    print("Succes")}
                else{
                  print("Failed")  }}
