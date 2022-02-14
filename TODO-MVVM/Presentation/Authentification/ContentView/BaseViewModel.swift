//
//  BaseViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import Combine
import Network
class BaseViewModel: ObservableObject {
    @Published var networkStatus: NWPath.Status = .satisfied
    private let monitorQueue = DispatchQueue(label: "monitor")
    var subscriptions = Set<AnyCancellable>()

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
}
