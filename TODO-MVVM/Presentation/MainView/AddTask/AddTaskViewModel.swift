//
//  AddTaskViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 19/2/2022.
//

import Foundation
import Combine
import Network
import SwiftUI


typealias AddTaskInputOutput = AddTaskViewModelInput & AddTaskViewModelOutput
protocol AddTaskViewModelInput {
    func viewDidLoad()
    func addTask()
}

protocol AddTaskViewModelOutput {
    var state: AddTaskViewModel.State { get }
}
class AddTaskViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case success(AddTaskResponse)
        case fail(Error)
    }
    @Published var description: String = ""
    @Published var descValid: Bool = false
    @Published var canSubmit: Bool = false
    var descriptionPrompt: String {
        descValid ? "Your task will start Today" : TextConstants.descriptionPrompt
    }
        var subscriptions = Set<AnyCancellable>()
        private let useCase: TaskUseCaseProtocol
        @Published private(set) var state = State.initial

         init(
            useCase: TaskUseCaseProtocol
         ) {
            self.useCase = useCase
             checkInputContent()
        }
    
    
    func checkInputContent() {
        $description
            .map({!$0.isEmpty})
            .assign(to: \.descValid, on: self)
            .store(in: &subscriptions) 
        
        $descValid
            .map({$0})
            .assign(to: \.canSubmit, on: self)
            .store(in: &subscriptions)
    }

    
}


extension AddTaskViewModel: AddTaskInputOutput {
    func viewDidLoad() {
        self.description = ""
    }
    
    func addTask() {
        guard !description.isEmpty else {
            self.state = .fail(TasksError.descriptionNotFound)
            return
        }
        useCase.execute(item: AddTaskRequest(description: description))
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.state = .fail(error)
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                debugPrint(response)
                self.state = .success(response)
            }
            .store(in: &subscriptions)
    }
    
    
}



enum TasksError: Error {
    case descriptionNotFound
}
