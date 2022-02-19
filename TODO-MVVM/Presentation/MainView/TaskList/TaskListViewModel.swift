//
//  TaskListViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation
import SwiftUI
enum TasksStatus {
    case all
    case completed
    case incompleted
}
class TaskListViewModel: ObservableObject {
    @Published  var toolbarIcon: String = "square.grid.2x2"
    @Published  var gridLayout: [GridItem] = [GridItem(.flexible())]
    @Published  var gridColumn: Int = 1
    

    let date: Date
    let tasks: Tasks
    init(
        tasks: Tasks,
        date: Date
    ) {
        self.tasks = tasks
        self.date = date
    }
    
    func filterAssignment(status: TasksStatus) -> Tasks {
        switch status {
        case .all:
            return tasks.filter({convertTaskDate(dateTaskString: $0.createdAt) == convertSelectedDate()})
        case .completed:
            return tasks.filter({$0.completed}).filter({convertTaskDate(dateTaskString: $0.createdAt) == convertSelectedDate()})
        case .incompleted:
            return tasks.filter({!$0.completed}).filter({convertTaskDate(dateTaskString: $0.createdAt) == convertSelectedDate()})
       
        }
    }
    
    
    private func convertSelectedDate() -> String{
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func convertTaskDate(dateTaskString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateTask = dateFormatter.date(from: dateTaskString) ?? Date()
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy-MM-dd"
        return newDateFormatter.string(from: dateTask)
    }
    
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        gridColumn = gridLayout.count
        switch gridColumn {
        case 1: toolbarIcon = "square.grid.2x2.fill"
        case 2:  toolbarIcon = "square.grid.3x2.fill"
        case 3:  toolbarIcon = "rectangle.grid.1x2.fill"
        default:  toolbarIcon = "square.grid.2x2.fill"
        }
    }
}
