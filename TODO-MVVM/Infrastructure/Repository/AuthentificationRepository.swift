//
//  AuthentificationRepository.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import Combine
protocol AuthentificationRepositoryProtocol {
     func registerUser(request: RegisterRequest) -> AnyPublisher<RegisterResponse, NetworkError>
}

class AuthentificationRepository: AuthentificationRepositoryProtocol {
    func registerUser(request: RegisterRequest) -> AnyPublisher<RegisterResponse, NetworkError> {
        let endpoint = AuthentificationServiceEndpoints.registerUser(request: request)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
  
}

struct RegisterRequest: Codable {
    let name, email, password: String
    let age: Int
}

struct RegisterResponse: Codable {
    let user: User
    let token: String
}
