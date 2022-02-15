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
    func LoginUser(request: LoginRequest) -> AnyPublisher<RegisterResponse, NetworkError>
    func saveUserData(request: RegisterResponse) -> AnyPublisher<Bool, Never>
    func getUserData()   -> AnyPublisher<RegisterResponse?, KeyChainError>
}

class AuthentificationRepository: AuthentificationRepositoryProtocol {
    func LoginUser(request: LoginRequest) -> AnyPublisher<RegisterResponse, NetworkError> {
        let endpoint = AuthentificationServiceEndpoints.loginUser(request: request)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
    
    func getUserData()  -> AnyPublisher<RegisterResponse?, KeyChainError> {
        return KeychainStorage.getCredentials()
    }
    
    func saveUserData(request: RegisterResponse) -> AnyPublisher<Bool, Never> {
       return KeychainStorage.saveCredentials(request)
    }
    
    func registerUser(request: RegisterRequest) -> AnyPublisher<RegisterResponse, NetworkError> {
        let endpoint = AuthentificationServiceEndpoints.registerUser(request: request)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
  
}

