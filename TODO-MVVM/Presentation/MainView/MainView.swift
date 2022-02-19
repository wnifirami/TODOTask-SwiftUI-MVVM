//
//  MainView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 16/2/2022.
//

import SwiftUI

struct MainView: View {
    @State private var date = Date()
    @State private var tapped: Bool = false
    @ObservedObject var viewModel: MainViewModel
    
    init(
        viewModel: MainViewModel
    ) {
        self.viewModel = viewModel
        
    }

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.3)
                .ignoresSafeArea(.all)
            VStack {
              
                CalendarView(date: $date)
                createView()
                Spacer()
                   
            }
            if tapped {
                ZStack {
                    ColorConstants.darkGray.opacity(0.8)
                        .ignoresSafeArea(.all)
                        AddTaskView()
                }
                
            }
        }
        .onAppear {
            viewModel.viewDidLoad()
        }
        .overlay(VStack {
            Spacer()
            HStack{
                Spacer()
                Button {
                    withAnimation {
                        tapped.toggle()

                    }
                    
                } label: {
                    Image(systemName: tapped ? "xmark" : "plus")
                        .font(.title)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .padding()
                        .shadow(color: .white, radius: 2, x: 0, y: 2)
                        .background(Circle().fill(Color.blue) )
                       
                }
                .shadow(color: .secondary, radius: 4, x: 1, y: 2)
                .padding()

            }
        })
      
        
    }
    
    @ViewBuilder
    private func createView() -> some View {
        switch viewModel.state {
        case .initial,.loading:
           Spinner()
        case.success(let tasks):
            TaskListFactory.makeView(for: tasks, date: date)
        case .fail(let error):
            ErrorViewFactory.makeView(
                from: error.localizedDescription,
                isNetwork: false
            )

        }
    }
    
}

