//
//  TaskItemFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 19/2/2022.
//

import Foundation
import SwiftUI
protocol TaskItemManufactoring {
    static func makeView(for item: Task) -> TaskItemView
}
// MARK: - Factory
final class TaskItemFactory: TaskItemManufactoring {
    
    public func configureView(with item: Task) -> TaskItemView {
        let viewModel = makeViewModel(item: item)
        let view = TaskItemView(viewModel: viewModel)
        return view
    }
    

    private func makeViewModel(item: Task) -> TaskItemViewModel {
        return TaskItemViewModel(item: item)
    }
    
    public static func makeView(for item: Task) -> TaskItemView {
        return self.init().configureView(with: item)
    }
}
