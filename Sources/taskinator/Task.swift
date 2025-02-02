import ArgumentParser
import Rainbow
import Foundation

class Task {
  
  func getTasks(_ file: File) -> [String] {
    let tasks = file.readContentsOf()

    var tasksArray = tasks.components(separatedBy: "\n")
    
    let indexOfEmptyString = tasksArray.firstIndex(of: "")
    
    if indexOfEmptyString != nil {
      tasksArray.remove(at: indexOfEmptyString!)
    }

    return tasksArray
  }
  
  func isTaskFinished(_ task: String) -> Bool {
    let firstChar = Array(task)[0]
    
    if firstChar == "_" {
      return true
    } else {
      return false
    }
  }
  
  func showTasks(_ tasks: [String]) -> Void {
    print("\n")
    for (i, task) in tasks.enumerated() {
      if(isTaskFinished(task)) {
        var finishedTask = task
        finishedTask.remove(at: finishedTask.startIndex)
        print("\(i). \(finishedTask)".lightBlack)
      } else {
        print("\(i). \(task)")
      }
    }
    print("\n")
  }
  
  func finishTask(index: Int, _ tasksFromFile: [String], _ file: File) -> String {
    
    if index >= tasksFromFile.count {
      return "Index out of range"
    }
    var tasks = tasksFromFile
    let task = tasks[index]
    
    if !isTaskFinished(task) {
      let completedTask = "_\(task)"
      
      tasks.replaceSubrange(index...index, with: [completedTask])
      
      let stringTasks = tasks.joined(separator: "\n")
      
      file.overwrite(text: stringTasks)
      return "ok"
    } else {
      return "Essa atividade ja foi completada"
    }
  }
  
  func addTask(file: File, task: String) -> [String] {
    let taskToAdd = task + "\n"
    _ = file.append(text: taskToAdd)
    
    return getTasks(file)
  }
  
  func deleteTask(index: Int, _ tasksFromFile: [String], _ file: File) -> String {
    if index >= tasksFromFile.count {
      return "Index fora de range"
    }
    
    var tasks = tasksFromFile

    let removedTask = tasks.remove(at: index)
    
    let stringTasks = tasks.joined(separator: "\n")
    
    file.overwrite(text: stringTasks)
    
    return removedTask
    
  }
  
  func deleteAllTasks(_ file: File) {
    
    file.overwrite(text: "")
    
  }
  
}
