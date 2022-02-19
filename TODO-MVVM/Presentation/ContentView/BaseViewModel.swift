//
//  BaseViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import Combine
import Network
import SwiftUI
class BaseViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var networkStatus: NWPath.Status = .satisfied
    private let monitorQueue = DispatchQueue(label: "monitor")
    var subscriptions = Set<AnyCancellable>()
    init() {
        checkToken()
    }
}


extension BaseViewModel: NetworkingProtocol {
    func observeNetworkStatus() {
       NWPathMonitor()
           .publisher(queue: monitorQueue)
           .receive(on: DispatchQueue.main)
           .sink { [weak self] status in
                self?.networkStatus = status
           }
           .store(in: &subscriptions)
   }
    
    func redirectToMain() {
        self.isLoggedIn = true
    }
    
    func checkToken(){
        var subscriptions = Set<AnyCancellable>()
        let _ = KeychainStorage.getCredentials()
            .sink { (completion) in
                switch completion {
                case .failure:
                    self.isLoggedIn = false
                    case .finished:
                   break
                }
            } receiveValue: { result in
                if let _ = result?.token  {
                    self.isLoggedIn = true
                } else {
                    self.isLoggedIn = false
                }
            }
            .store(in: &subscriptions)
            
    }
}
