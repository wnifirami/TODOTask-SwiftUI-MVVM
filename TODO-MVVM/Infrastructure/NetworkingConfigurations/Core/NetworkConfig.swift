//
//  NetworkConfig.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: String { get }

}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public var baseURL: String

    
     public init(baseURL: String) {
        self.baseURL = baseURL
    }
}
