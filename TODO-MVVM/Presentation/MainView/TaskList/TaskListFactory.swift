//
//  TaskListFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 19/2/2022.
//

import Foundation
import SwiftUI
protocol TaskListManufactoring {
    static func makeView(for items: Tasks, date: Date) -> TaskListView
}
// MARK: - Factory
final class TaskListFactory: TaskListManufactoring {
    
    public func configureView(with items: Tasks, forDate: Date) -> TaskListView {
        let viewModel = makeViewModel(items: items, date: forDate)
        let view = TaskListView(viewModel: viewModel)
        return view
    }
    

    private func makeViewModel(items: Tasks, date: Date) -> TaskListViewModel {
        return TaskListViewModel(tasks: items, date: date)
    }
    
    public static func makeView(for items: Tasks, date: Date) -> TaskListView {
        return self.init().configureView(with: items, forDate: date)
    }
}

