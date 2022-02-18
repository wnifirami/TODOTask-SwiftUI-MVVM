//
//  TaskRepository.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//


import Foundation
import Combine
protocol TasksRepositoryProtocol {
     func getTasks() -> AnyPublisher<TaskResponse, NetworkError>
}

class TasksRepository: TasksRepositoryProtocol {

    func getTasks() -> AnyPublisher<TaskResponse, NetworkError> {
        let endpoint = TasksServiceEndpoints.getTasks
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
  
}


