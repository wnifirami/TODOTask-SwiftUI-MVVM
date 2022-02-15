//
//  ErrorView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import SwiftUI

struct ErrorView: View {
 let viewModel: ErrorViewModel
    init(
        viewModel: ErrorViewModel
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: viewModel.isNetwork ? ImageNames.xmarkCloud : ImageNames.xmarkCircle)
                .resizable()
                .frame(width: 120, height: 80, alignment: .center)
                .scaledToFit()
                .foregroundColor(.red)
                .padding()
            Text(viewModel.message)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
        }
        
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding()
        .shadow(color: .secondary, radius: 4)
    }
    
}
