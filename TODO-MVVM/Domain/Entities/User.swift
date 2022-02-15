//
//  User.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let age: Int
    let id, name, email, createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case age
        case id = "_id"
        case name, email, createdAt, updatedAt
        case v = "__v"
    }
}

struct RegisterRequest: Codable {
    let name, email, password: String
    let age: Int
}

struct LoginRequest: Codable {
    let email, password: String
}

struct RegisterResponse: Codable {
    let user: User
    let token: String
}
