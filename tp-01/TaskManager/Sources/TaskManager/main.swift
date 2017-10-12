import TaskManagerLib
import PetriKit

//Florian Iannalfo TP1

let taskManager = createTaskManager()

let create = taskManager.transitions.first { $0.name == "create" }!
let spawn = taskManager.transitions.first { $0.name == "spawn" }!
let success = taskManager.transitions.first { $0.name == "success" }!
let exec = taskManager.transitions.first { $0.name == "exec" }!
let fail = taskManager.transitions.first { $0.name == "fail" }!
let taskPool = taskManager.places.first { $0.name == "taskPool" }!
let processPool = taskManager.places.first { $0.name == "processPool" }!
let inProgress = taskManager.places.first { $0.name == "inProgress" }!

//----------------------------------------------------------------------------------------------------
// Exercice 3:

print("")
print("Exercie 3")
print("")

let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
print(m1!)
let m2 = spawn.fire(from: m1!)
 print(m2!)
let m3 = spawn.fire(from: m2!)
 print(m3!)
let m4 = exec.fire(from: m3!)
 print(m4!)
let m5 = exec.fire(from: m4!)
 print(m5!)
let m6 = success.fire(from: m5!)
 print(m6!)

//Içi, cette série de place et transitions cause un problème: Un process va rester coincé dans inProgress car on peux executer deux fois.
//----------------------------------------------------------------------------------------------------
// Exercice 4 :

print("")
print("Exercice 4")
print("")

let correctTaskManager = createCorrectTaskManager()

// Importation des transitions et places du correctTaskManager
let createE = correctTaskManager.transitions.first{$0.name == "create"}!
let spawnE = correctTaskManager.transitions.first{$0.name == "spawn"}!
let execE = correctTaskManager.transitions.first{$0.name == "exec"}!
let successE = correctTaskManager.transitions.first{$0.name == "success"}!
let failE = correctTaskManager.transitions.first{$0.name == "fail"}!
let taskPoolE = correctTaskManager.places.first{$0.name == "taskPool"}!
let ProcessPoolE = correctTaskManager.places.first{$0.name == "processPool"}!
let inProgressE = correctTaskManager.places.first{$0.name == "inProgress"}!
let storage = correctTaskManager.places.first{$0.name == "storage"}!

// Içi le problème est réglé grace à une nouvelle place "storage" qui permet d'éviter qu'un jeton sois coincé dans "in progress" ce qui veut dire qu'il n'est pas possible d'éxecuter deux fois.

let m7 = createE.fire(from: [taskPoolE: 0, ProcessPoolE: 0, inProgressE: 0, storage: 0])
print(m7!)
let m8 = spawnE.fire(from: m7!)
print(m8!)
let m9 = spawnE.fire(from: m8!)
print(m9!)
let m10 = execE.fire(from: m9!)
print(m10!)
let m11 = successE.fire(from: m10!)
print(m11!)
let m12 = failE.fire(from: m10!)
print(m12!)
