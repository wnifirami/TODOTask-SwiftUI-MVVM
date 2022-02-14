//
//  RegisterFActory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import SwiftUI
protocol RegisterViewManufactoring {
     static func makeView() -> RegisterView
}
// MARK: - Factory
final class RegisterViewFactory: RegisterViewManufactoring {
    
   public func configureView() -> RegisterView {
        let viewModel = makeRegisterViewModel()
        let view = RegisterView(viewModel: viewModel)
        return view
    }
    
    private func makeRepository() -> AuthentificationRepositoryProtocol {
        return AuthentificationRepository()
    }
    
    private func makeRegisterUseCase() -> RegisterUseCaseProtocol {
        return RegisterUseCase(registerRepository: makeRepository())
    }
    
    private func makeRegisterViewModel() -> RegisterViewModel {
        return RegisterViewModel(useCase: makeRegisterUseCase())
    }
    
    public static func makeView() -> RegisterView {
        return self.init().configureView()
    }
}

