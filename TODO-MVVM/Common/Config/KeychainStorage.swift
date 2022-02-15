//
//  KeychainStorage.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
import SwiftKeychainWrapper
import Combine

enum KeychainStorage {
    static let key = "credentials"
    
    static func getCredentials()  -> AnyPublisher<RegisterResponse?, KeyChainError>{
        if let myCredentialsData = KeychainWrapper.standard.string(forKey: Self.key) {
            return Result<RegisterResponse?, KeyChainError>.Publisher(Bundle.main.decode(myCredentialsData)).eraseToAnyPublisher()
        } else {
            return AnyPublisher(
                Fail<RegisterResponse?, KeyChainError>(error: KeyChainError.notfound)
            )
        }
    }
    
    static func saveCredentials(_ credentials: RegisterResponse) ->  AnyPublisher<Bool, Never> {
        guard let data = try? Bundle.main.encode(credentials) else {
            return Just(false).eraseToAnyPublisher()
        }
        if KeychainWrapper.standard.set(data, forKey: Self.key) {
            return Just(true).eraseToAnyPublisher()
        } else {
            return Just(false).eraseToAnyPublisher()
        }
    }
    
    static func deleteCredentials() -> AnyPublisher<Bool, Never> {
        if KeychainWrapper.standard.removeObject(forKey: Self.key) {
            return Just(true).eraseToAnyPublisher()
        } else {
            return Just(false).eraseToAnyPublisher()

        }
    }
}

enum KeyChainError: Error {
    case notfound
    case notsaved
}
