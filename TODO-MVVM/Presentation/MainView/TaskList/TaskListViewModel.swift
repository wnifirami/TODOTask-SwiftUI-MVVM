//
//  TaskListViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation

enum TasksStatus {
    case all
    case completed
    case incompleted
}
class TaskListViewModel: ObservableObject {
    let tasks: Tasks
    init(tasks: Tasks) {
        self.tasks = tasks
    }
    
    func filterAssignment(status: TasksStatus ) -> Tasks {
        switch status {
        case .all:
            return tasks
        case .completed:
            return tasks.filter({$0.completed})
        case .incompleted:
           return tasks.filter({!$0.completed})
       
        }
    }
}
