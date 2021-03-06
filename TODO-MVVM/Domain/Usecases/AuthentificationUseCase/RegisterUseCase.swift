//
//  RegisterUseCase.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import Combine
protocol RegisterUseCaseProtocol {
    func execute(requestValue: RegisterRequest)  -> AnyPublisher<RegisterResponse, NetworkError>
    func saveUser(requestValue: RegisterResponse)  -> AnyPublisher<Bool, Never>
    func getUser() -> AnyPublisher<RegisterResponse?, KeyChainError>
}



class RegisterUseCase: RegisterUseCaseProtocol {
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

    func execute(requestValue: RegisterRequest)  -> AnyPublisher<RegisterResponse, NetworkError> {
        registerRepository.registerUser(request: requestValue)
    }
}


