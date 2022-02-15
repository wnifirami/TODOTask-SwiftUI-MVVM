//
//  LoginViewFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
import SwiftUI
protocol LoginViewManufactoring {
     static func makeView() -> LoginView
}
// MARK: - Factory
final class LoginViewFactory: LoginViewManufactoring {
    
   public func configureView() -> LoginView {
        let viewModel = makeLoginViewModel()
        let view = LoginView(viewModel: viewModel)
        return view
    }
    
    private func makeRepository() -> AuthentificationRepositoryProtocol {
        return AuthentificationRepository()
    }
    
    private func makeRegisterUseCase() -> LoginUseCaseProtocol {
        return LoginUseCase(registerRepository: makeRepository())
    }
    
    private func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(useCase: makeRegisterUseCase())
    }
    
    public static func makeView() -> LoginView {
        return self.init().configureView()
    }
}
