//
//  ErrorViewFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation
protocol ErrorViewManufactoring {
    static func makeView(
        from message: String,
        isNetwork: Bool
    ) -> ErrorView
}
// MARK: - Factory
final class ErrorViewFactory: ErrorViewManufactoring {
    static func makeView(
        from message: String,
        isNetwork: Bool
    ) -> ErrorView{
        return self.init().configureView(
            from: message,
            isNetwork: isNetwork
        )
    }
    
    public func configureView(
        from message: String,
        isNetwork: Bool
    ) -> ErrorView {
        let viewModel = makeViewModel(
            from: message,
            isNetwork: isNetwork
        )
        let view = ErrorView(viewModel: viewModel)
        return view
    }
    
    private func makeViewModel(
        from message: String,
        isNetwork: Bool
    ) -> ErrorViewModel {
        return ErrorViewModel(
            message: message,
            isNetwork: isNetwork
        )
    }
    
    
}
