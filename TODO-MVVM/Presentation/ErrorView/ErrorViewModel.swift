//
//  ErrorViewModel.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
struct ErrorViewModel{
    let message: String
    let isNetwork: Bool
    init(
        message: String,
        isNetwork: Bool
    ) {
        self.message = message
        self.isNetwork = isNetwork
    }    
}

