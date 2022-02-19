//
//  LoginViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
import Combine
typealias LoginInputOutput = LoginViewModelOutput & LoginViewModelOutput

protocol LoginViewModelInput {
    func viewDidLoad()
    func loginUser()
}

protocol LoginViewModelOutput {
    var state: LoginViewModel.State { get }
}
class LoginViewModel: BaseViewModel {

    
enum State: Equatable {
    static func == (lhs: LoginViewModel.State, rhs: LoginViewModel.State) -> Bool {
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
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailValid: Bool = false
    @Published var passwordValid: Bool = false
    
    @Published var canSubmit: Bool = false
    @Published private(set) var state = State.initial
    
    var emailPrompt: String {
        emailValid ? "" : TextConstants.emailPrompt
    }

    var passwordPrompt: String {
        passwordValid ? "" : TextConstants.passwordPrompt
    }
    private let useCase: LoginUseCaseProtocol
    
     init(
        useCase: LoginUseCaseProtocol
     ) {
        self.useCase = useCase
         super.init()
         self.checkInputContent()
    }
    
    func viewDidLoad() {
        self.email = ""
        self.password = ""

    }
    
    func checkInputContent() {
        $email
            .map({ $0.isValidEmail() && !$0.isEmpty})
            .assign(to: \.emailValid, on: self)
            .store(in: &subscriptions)

        
        $password
            .map({ $0.isValidPassword() && !$0.isEmpty})
            .assign(to: \.passwordValid, on: self)
            .store(in: &subscriptions)
        
        Publishers.CombineLatest($emailValid,$passwordValid)
            .map({$0 && $1})
            .assign(to: \.canSubmit, on: self)
            .store(in: &subscriptions)
    }

}


extension LoginViewModel:  LoginInputOutput {    
    func loginUser() {
        self.state = .loading
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
                self.saveUserInKeyChain(user: response)
                debugPrint(response)
                
                self.state = .success(response)
                self.redirectToMain()
                
            }
            .store(in: &subscriptions)
    }
    
    private func saveUserInKeyChain(user: RegisterResponse) {
        
        useCase.saveUser(requestValue: user)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure( _):
                   debugPrint("can't save")
                case .finished:
                   break
                }
            } receiveValue: { result in
                if result {
                    debugPrint("saved")
                } else {
                    debugPrint("not saved")
                }
            }
            .store(in: &subscriptions)

    }
        private func makeQuery() -> LoginRequest {
            return LoginRequest( email: email, password: password)
        }
}
