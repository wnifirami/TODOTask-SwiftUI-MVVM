//
//  AddTaskFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 10/3/2022.
//

import Foundation
import SwiftUI
protocol AddTaskViewwManufactoring {
     static func makeView() -> AddTaskView
}
// MARK: - Factory
final class AddTaskViewFactory: AddTaskViewwManufactoring {
    
   public func configureView() -> AddTaskView {
        let viewModel = makeViewModel()
        let view = AddTaskView(viewModel: viewModel)
        return view
    }
    
    private func makeRepository() -> TasksRepositoryProtocol {
        return TasksRepository()
    }
    
    private func makeUseCase() -> TaskUseCaseProtocol {
        return TaskUseCase(taskRepository: makeRepository())
    }
    
    private func makeViewModel() -> AddTaskViewModel {
        return AddTaskViewModel(useCase: makeUseCase())
    }
    
    public static func makeView() -> AddTaskView {
        return self.init().configureView()
    }
}
