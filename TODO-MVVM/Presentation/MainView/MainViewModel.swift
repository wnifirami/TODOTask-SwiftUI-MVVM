//
//  MainViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation
import Foundation
import Combine
typealias MainInputOutput = MainViewModelInput & MainViewModelOutput

protocol MainViewModelInput {
    func viewDidLoad()
    func getTasks()
}

protocol MainViewModelOutput {
    var state: MainViewModel.State { get }
}
class MainViewModel: ObservableObject {

    
enum State {
    case initial
    case loading
    case success(Tasks)
    case fail(Error)
}
    
    var subscriptions = Set<AnyCancellable>()
    private let useCase: TaskUseCaseProtocol
    @Published private(set) var state = State.initial

     init(
        useCase: TaskUseCaseProtocol
     ) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        getTasks()
    }
}


extension MainViewModel:  MainInputOutput {
    func getTasks() {
        useCase.execute()
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
                self.state = .success(response.data)
            }
            .store(in: &subscriptions)
    }
    
    
    
     
}
