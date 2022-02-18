//
//  MainView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 16/2/2022.
//

import SwiftUI

struct MainView: View {
    @State private var date = Date()
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
                   
            }
        }
        .onAppear {
            viewModel.viewDidLoad()
        }
      
        
    }
    
    @ViewBuilder
    private func createView() -> some View {
        switch viewModel.state {
        case .initial,.loading:
           EmptyView()
        case.success(let tasks):
            TaskListView(viewModel: TaskListViewModel(tasks: tasks))
        case .fail(let error):
           EmptyView()

        }
    }
    
}

