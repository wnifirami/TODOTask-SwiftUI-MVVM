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
    func addTask(from task: AddTaskRequest) -> AnyPublisher<AddTaskResponse, NetworkError>
}

class TasksRepository: TasksRepositoryProtocol {
    func addTask(from task: AddTaskRequest) -> AnyPublisher<AddTaskResponse, NetworkError> {
        let endpoint = TasksServiceEndpoints.addTask(request: task)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
    
 
    

    func getTasks() -> AnyPublisher<TaskResponse, NetworkError> {
        let endpoint = TasksServiceEndpoints.getTasks
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
  
}


