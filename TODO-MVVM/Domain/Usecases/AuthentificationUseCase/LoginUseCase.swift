//
//  LoginUseCase.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
import Combine
protocol LoginUseCaseProtocol {
    func execute(requestValue: LoginRequest)  -> AnyPublisher<RegisterResponse, NetworkError>
    func saveUser(requestValue: RegisterResponse)  -> AnyPublisher<Bool, Never>
    func getUser() -> AnyPublisher<RegisterResponse?, KeyChainError>
}



class LoginUseCase: LoginUseCaseProtocol {
    func getUser() -> AnyPublisher<RegisterResponse?, KeyChainError> {
        return registerRepository.getUserData()
    }
    
    func saveUser(requestValue: RegisterResponse) -> AnyPublisher<Bool, Never> {
       return registerRepository.saveUserData(request: requestValue)
    }
    

    private let registerRepository: AuthentificationRepositoryProtocol

    init(
        registerRepository: AuthentificationRepositoryProtocol
       ) {

        self.registerRepository = registerRepository
    }

    func execute(requestValue: LoginRequest)  -> AnyPublisher<RegisterResponse, NetworkError> {
        registerRepository.LoginUser(request: requestValue)
    }
}
