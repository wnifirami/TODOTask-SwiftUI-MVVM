//
//  LoginView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
        
    }
    var body: some View {
        VStack(alignment: .center, spacing: 15.0){
            EntryField(iconName: "envelope", placeholder: "Email", prompt: viewModel.emailPrompt, field: $viewModel.email)
            EntryField(iconName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt,isSecure: true,isPasswordField: true, field: $viewModel.password)


                Button(action: {
                    viewModel.loginUser()

                }, label: {
                    Text("Sign in")
                        .font(.body)
                        .fontWeight(.semibold)
                })
                
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 30)
                .background(Capsule().fill(Color.blue))
                .opacity(viewModel.canSubmit ? 1 : 0.6)
                .disabled(!viewModel.canSubmit)

            }.padding()
    }
}


