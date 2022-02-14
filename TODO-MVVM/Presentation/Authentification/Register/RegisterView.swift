//
//  RegisterView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    init(
        viewModel: RegisterViewModel
    ) {
        self.viewModel = viewModel
        
    }
    var body: some View {
        VStack(alignment: .center, spacing: 15.0){
            VStack(alignment: .leading,spacing: 5) {
                Text("Task")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.horizontal)
                    .foregroundColor(.red)
               
                Text("odo")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.blue)
            }
            .padding(.vertical, 40)
            EntryField(iconName: "person", placeholder: "Full name", prompt: viewModel.namePrompt, field: $viewModel.name)
            EntryField(iconName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt,isSecure: true,isPasswordField: true, field: $viewModel.password)
            EntryField(iconName: "calendar", placeholder: "Age", prompt: viewModel.agePrompt, field: $viewModel.age)
            EntryField(iconName: "envelope", placeholder: "Email", prompt: viewModel.emailPrompt, field: $viewModel.email)


                Button(action: {
                    viewModel.registerUser()

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

