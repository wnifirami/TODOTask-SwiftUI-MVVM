//
//  ContentFactory.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
import SwiftUI
protocol ContentManufactoring {
    static func makeView() -> ContentView
}
// MARK: - Factory
final class ContentViewFactory: ContentManufactoring {
    static func makeView() -> ContentView {
        return self.init().configureView()
    }
    
    
   public func configureView() -> ContentView {
        let viewModel = makeViewModel()
        let view = ContentView(viewModel: viewModel)
        return view
    }

    private func makeViewModel() -> BaseViewModel {
        return BaseViewModel()
    }
    
     
}

