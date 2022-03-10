//
//  AddTaskView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 19/2/2022.
//

import SwiftUI
import Combine
struct AddTaskView: View {
    
    @State private var completed: Bool = false
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddTaskViewModel
    
    init(
        viewModel: AddTaskViewModel
    ) {
        self.viewModel = viewModel
    }
    var body: some View {
        
        createView()
    }
    
    @ViewBuilder
    private func createView() -> some View {
        switch viewModel.state {
        case .initial:
            createTaskView()
                .onAppear {
                    viewModel.viewDidLoad()
                }
        case .loading:
            Spinner()
        case.success:
            makeResultView(from: "your task is successfuly added")
        case .fail(let error):
            makeResultView(from: error.localizedDescription)
            
            
        }
    }
    
    
    @ViewBuilder
    private func createTaskView() -> some View {
        ZStack {
            ColorConstants.darkGray.opacity(0.8)
                .ignoresSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Task for Today")
                            .font(.body)
                            .fontWeight(.bold)
                        Spacer()
                        Button {
                            viewModel.addTask()
                        } label: {
                            HStack {
                                Image(systemName: "plus" )
                                    .font(.body)
                                    .foregroundColor(viewModel.canSubmit ? .blue : .secondary)
                                Text("ADD")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(viewModel.canSubmit ? .blue : .secondary)
                            }
                            .padding()
                            
                        }
                        .opacity(viewModel.canSubmit ? 1 : 0.6)
                        .disabled(!viewModel.canSubmit)
                        
                    }
                    .padding()
                    Divider()
                    TextField("Describe your task", text: $viewModel.description)
                        .frame( height: 200, alignment: .center)
                        .padding()
                    Divider()
                    HStack {
                        Text(viewModel.descriptionPrompt)
                            .font(.footnote)
                            .fontWeight(viewModel.canSubmit ? .light : .regular)
                            .foregroundColor(viewModel.canSubmit ? .secondary : .red)
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 2) {
                                Image(systemName: "xmark" )
                                    .font(.body)
                                    .foregroundColor(.blue)
                                Text("Cancel")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                }
                .background(ColorConstants.darkYellowColor)
                .padding()
                .shadow(color: .secondary, radius: 2, x: 0, y: 1)
                
                
            }
        }
    }
    
    
    @ViewBuilder
    private func makeResultView(from text: String) -> some View {
        VStack {
            Text(text)
                .font(.title3)
                .fontWeight(.regular)
            
            Button {
                dismiss()
            } label: {
                Text("OK")
                    .foregroundColor(.white)
            }
            .padding(.all, 10)
            .cornerRadius(6)
            .background(Color.blue
             .cornerRadius(6))
            
            
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .padding()
        .shadow(color: .secondary, radius: 4)
        
    }
}

