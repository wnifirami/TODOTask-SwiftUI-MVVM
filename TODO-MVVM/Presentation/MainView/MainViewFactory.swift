//
//  MainViewFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation
import SwiftUI
protocol MainViewManufactoring {
     static func makeView() -> MainView
}
// MARK: - Factory
final class MainViewFactory: MainViewManufactoring {
    
   public func configureView() -> MainView {
        let viewModel = makeViewModel()
        let view = MainView(viewModel: viewModel)
        return view
    }
    
    private func makeRepository() -> TasksRepositoryProtocol {
        return TasksRepository()
    }
    
    private func makeUseCase() -> TaskUseCaseProtocol {
        return TaskUseCase(taskRepository: makeRepository())
    }
    
    private func makeViewModel() -> MainViewModel {
        return MainViewModel(useCase: makeUseCase())
    }
    
    public static func makeView() -> MainView {
        return self.init().configureView()
    }
}

