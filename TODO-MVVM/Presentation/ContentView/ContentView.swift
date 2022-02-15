//
//  ContentView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BaseViewModel
    
    init(
        viewModel: BaseViewModel
    ) {
        self.viewModel = viewModel
        
    }
    var body: some View {
       createView()
    }
    
    
    @ViewBuilder
    private func createView() -> some View {
        VStack {
            switch viewModel.networkStatus {
            case .satisfied:
                RegisterViewFactory.makeView()

            default:
//                ErrorViewsFactory.configureErrorView(
//                    from: offline_error,
//                    isNetwork: true
//                )
Text("oooops! no network")
            }
        }
    }
}

