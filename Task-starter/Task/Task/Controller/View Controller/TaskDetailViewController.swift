//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Justin Lowry on 12/15/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    // MARK: - Properties
    var task: Task?
    var date: Date?
    

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var taskNotesTextView: UITextView!
    
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistentStorage()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField?.text else { return }
        let notes = taskNotesTextView?.text
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        if let date = task.dueDate {
            taskDueDatePicker.date = date
        }
    }
}
