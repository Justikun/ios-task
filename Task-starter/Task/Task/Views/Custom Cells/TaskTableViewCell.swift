//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Justin Lowry on 12/16/21.
//

import UIKit

protocol TaskCompletetionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.taskCellButtonTapped(self)
    }
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletetionDelegate? {
        didSet {
            print("Delegate assigned")
        }
    }
    
    // MARK: - Helper functions
    func updateViews() {
        guard let task = task else { return }
        if let taskName = taskNameLabel.text {
            task.name = taskName
        }
        
        if task.isComplete {
            completionButton.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            completionButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        }
    }
}
