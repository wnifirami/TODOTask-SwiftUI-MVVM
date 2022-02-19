//
//  ContentView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @ObservedObject var viewModel: BaseViewModel
    
    init(
        viewModel: BaseViewModel
    ) {
        self.viewModel = viewModel
        
    }
    var body: some View {
        if isLoggedIn {
            showMain()
        } else {
            createView()
        }
      
    }
    
    @State var loginSelected: Bool = true
    @ViewBuilder
    private func createView() -> some View {
        VStack {
            switch viewModel.networkStatus {
            case .satisfied:
                ZStack {
                   Color.gray.opacity(0.2).ignoresSafeArea(.all)
                    VStack {
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
                    createAuthView()
                            .padding(.horizontal, 30)
                        Spacer()
                    }
                }
               

            default:
                ErrorViewFactory.makeView(
                    from: TextConstants.offlineError,
                    isNetwork: true
                )
            }
        }
    }
    
    @ViewBuilder
    private func showMain() -> some View {
        MainViewFactory.makeView()
    }
    
    @ViewBuilder
    private func createAuthView() -> some View {
     
        VStack {

            createHeaderOffer()
            if loginSelected {
                LoginViewFactory.makeView()
            } else {
                RegisterViewFactory.makeView()
            }
          
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .shadow(color: .secondary, radius: 2, x: 0, y: 2)
        .cornerRadius(10)
        .padding()


    }
    
    @ViewBuilder
    private func createHeaderOffer() -> some View {
        HStack {
            
            VStack {
                Text("Login")
                        .foregroundColor(loginSelected ?  Color.blue : .primary)
                        .font(.title3)
                    .fontWeight(.bold)
                if loginSelected {
                Rectangle()
                    .fill(Color.blue.opacity(0.8))
                    .frame(height: 4)
                    .padding(.horizontal)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.4)
            .onTapGesture {
                withAnimation {
                    self.loginSelected = true
                }
            }
            Spacer()
            VStack {
                Text("Register")
                        .foregroundColor(!loginSelected ?  Color.blue : .primary)
                        .font(.title3)
                    .fontWeight(.bold)
                if !loginSelected {
                Rectangle()
                        .fill(Color.blue.opacity(0.8))
                    .frame(height: 4)
                }
            } .frame(width: UIScreen.main.bounds.width * 0.4)
            .onTapGesture {
                withAnimation {
                    self.loginSelected = false
                }
            }
            
        }
        .padding(.all, 5)
    }

}

