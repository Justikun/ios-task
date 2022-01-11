//
//  TaskController.swift
//  Task
//
//  Created by Justin Lowry on 12/15/21.
//

import Foundation

class TaskController {
    // Shared instance
    static var shared = TaskController()
    
    // Source of Truth
    var tasks: [Task] = []
    
    // CRUD
    // Create
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistentStorage()
    }
    
    //Update
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        guard let index = tasks.firstIndex(of: task) else { return }
        let taskToUpdate = tasks[index]
        taskToUpdate.name = name
        taskToUpdate.notes = notes
        taskToUpdate.dueDate = dueDate
        saveToPersistentStorage()
    }
    
    //Delete
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistentStorage()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStorage()
    }
    
    
    // MARK: - Methods
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Task.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        } catch let e {
            print("Error Encoding")
            print(e)
            print(e.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
            
        } catch let e {
            print("Error Decoding")
            print(e)
            print(e.localizedDescription)
        }
    }
}
