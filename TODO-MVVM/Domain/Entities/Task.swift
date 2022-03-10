//
//  Task.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 16/2/2022.
//

import Foundation

// MARK: - TaskResponse
struct TaskResponse: Codable {
    let count: Int
    let data: [Task]
}

// MARK: - Datum
struct Task: Codable, Identifiable {
    let completed: Bool
    let id, datumDescription, owner, createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case completed
        case id = "_id"
        case datumDescription = "description"
        case owner, createdAt, updatedAt
        case v = "__v"
    }
}

struct AddTaskResponse: Codable {
    let success: Bool
    let data: Task
}

struct AddTaskRequest: Codable {
    let description: String
}

typealias Tasks = [Task]
