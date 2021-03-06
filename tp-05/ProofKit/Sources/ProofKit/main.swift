import ProofKitLib
do{     		//Formules d'exercices de l'exercice 9 (fait en classe) pour test
  let a: Formula = "a"
  let b: Formula = "b"
  let c: Formula = "c"
//Exercice 2.1
  let f = !(a && (b || c))
  print("Resultat: \(f)")
  print(f.nnf)//NNF
  print(f.cnf)//CNF
  print(f.dnf)}//DNF
do{
  let a: Formula = "a"
  let b: Formula = "b"
  let c: Formula = "c"
//Exercice 2.2
  let f = (a => b) || !(a && c)
  print("Resultat: \(f)")
  print(f.nnf)//NNF
  print(f.cnf)//CNF
  print(f.dnf)}//DNF
do{
  let a: Formula = "a"
  let b: Formula = "b"
  let c: Formula = "c"
//Exercice 2.3
let f = (!a || b && c) && a
  print("Resultat: \(f)")
  print(f.nnf)//NNF
  print(f.cnf)//CNF
  print(f.dnf)//DNF
}
let a: Formula = "a"
let b: Formula = "b"
let f = a && b
print(f)
let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
