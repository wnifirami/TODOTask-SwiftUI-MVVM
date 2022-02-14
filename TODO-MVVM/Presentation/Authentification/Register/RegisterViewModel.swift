//
//  RegisterViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import Combine
import Network

typealias InputOutput = RegisterViewModelInput & RegisterViewModelOutput

protocol RegisterViewModelInput {
    func viewDidLoad()
    func registerUser()
}

protocol RegisterViewModelOutput {
    var state: RegisterViewModel.State { get }

}
    
class RegisterViewModel: ObservableObject {

    
enum State: Equatable {
    static func == (lhs: RegisterViewModel.State, rhs: RegisterViewModel.State) -> Bool {
        switch (lhs,rhs) {
        case (let .success(lhsdata), let .success(rhsdata)):
            return lhsdata.user.id == rhsdata.user.id
        case (let .fail(lhsfail), let .fail(rhsfail)):
            return lhsfail.localizedDescription == rhsfail.localizedDescription
        default:
            return false
        }
    }
    case initial
    case loading
    case success(RegisterResponse)
    case fail(Error)
    

}
    
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var age: String = ""
    
    @Published var nameValid: Bool = false
    @Published var emailValid: Bool = false
    @Published var passwordValid: Bool = false
    @Published var ageValid: Bool = false
    @Published var canSubmit: Bool = false
    @Published private(set) var state = State.initial

    var subscriptions = Set<AnyCancellable>()
    private let useCase: RegisterUseCaseProtocol
    
     init(
        useCase: RegisterUseCaseProtocol
     ) {
        self.useCase = useCase
         checkInputContent()
    }
    
    var namePrompt: String {
        nameValid ? "" : TextConstants.namePrompt
    }
    var emailPrompt: String {
        emailValid ? "" : TextConstants.emailPrompt
    }
    var agePrompt: String {
        ageValid ? "" : TextConstants.agePrompt
    }
    var passwordPrompt: String {
        passwordValid ? "" : TextConstants.passwordPrompt
    }
}



extension RegisterViewModel:  InputOutput {
    func registerUser() {
        useCase.execute(requestValue: makeQuery())
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
    
    func viewDidLoad() {
        self.email = ""
        self.password = ""
        self.age = ""
        self.name = ""
    }
    
    func checkInputContent() {
        $email
            .map({ $0.isValidEmail() && !$0.isEmpty})
            .assign(to: \.emailValid, on: self)
            .store(in: &subscriptions)
        
        $age
            .map({ $0.isValidAge() && !$0.isEmpty})
            .assign(to: \.ageValid, on: self)
            .store(in: &subscriptions)
        
        $name
            .map({ $0.isValidName() && !$0.isEmpty})
            .assign(to: \.nameValid, on: self)
            .store(in: &subscriptions)
        
        $password
            .map({ $0.isValidPassword() && !$0.isEmpty})
            .assign(to: \.passwordValid, on: self)
            .store(in: &subscriptions)
        
        Publishers.CombineLatest4($nameValid, $emailValid,$passwordValid, $ageValid)
            .map({$0 && $1 && $2 && $3})
            .assign(to: \.canSubmit, on: self)
            .store(in: &subscriptions)
    }
    private func makeQuery() -> RegisterRequest {
        return RegisterRequest(name: name, email: email, password: password, age: Int(age) ?? 0)
    }

}
