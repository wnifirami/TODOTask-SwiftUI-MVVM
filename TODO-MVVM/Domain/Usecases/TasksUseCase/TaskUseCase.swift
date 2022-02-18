//
//  TaskUseCase.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation
import Combine
protocol TaskUseCaseProtocol {
    func execute()  -> AnyPublisher<TaskResponse, NetworkError>
}



class TaskUseCase: TaskUseCaseProtocol {


    private let taskRepository: TasksRepositoryProtocol

    init(
        taskRepository: TasksRepositoryProtocol
       ) {

        self.taskRepository = taskRepository
    }

     func execute()  -> AnyPublisher<TaskResponse, NetworkError> {
        taskRepository.getTasks()
    }
}



