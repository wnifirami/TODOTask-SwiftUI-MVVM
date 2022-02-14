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
}



 class RegisterUseCase: RegisterUseCaseProtocol {

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


