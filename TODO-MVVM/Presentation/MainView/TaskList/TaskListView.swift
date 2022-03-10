//
//  TaskListView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import SwiftUI

struct TaskListView: View {
    @State private var isGridViewActive: Bool = false
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    @State var currentStatus: TasksStatus = .all
    @ObservedObject var viewModel: TaskListViewModel
    init(
        viewModel: TaskListViewModel    ) {
            self.viewModel = viewModel
            
        }
    var body: some View {
        VStack (alignment: .center){
            VStack {
                HStack {
                    Spacer()
                    
                    HStack(spacing: 16) {
                        createAssignmentMenuView(status: currentStatus)
                        Button (action: {
                            print ("grid item is activated")
                            isGridViewActive = true
                            haptics.impactOccurred()
                            viewModel.gridSwitch()
                        }) {
                            Image(systemName: viewModel.toolbarIcon)
                                .font(.title3)
                                .foregroundColor(Color.secondary)
                                .shadow(radius: 2)
                                .opacity(1)
                                .padding(.trailing, 20)
                            
                        }
                    }//: HStack
                }
                createList()
                    .animation(.easeIn)
            }
            
            .zIndex(0)
        }
    }
    @ViewBuilder
    private func createList() -> some View {
        let items = viewModel.filterAssignment(status: currentStatus)
        if items.isEmpty {
            VStack {
                Spacer()
                VStack() {
                    Image("taskNotFound")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .leading)
                    Text("No tasks were found for today!")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding()
                Spacer()
            }
        } else {
            Group {
                VStack {
                    ScrollView( .vertical, showsIndicators: false) {
                        LazyVGrid(columns: viewModel.gridLayout, alignment: .center, spacing: 10) {
                            ForEach(items) { item in
                                TaskItemFactory.makeView(for: item)
                            }
                        }
                        .padding(10)
                        .animation(.easeIn)
                    }
                }
            }
        }
        
    }
    @ViewBuilder
    private func createAssignmentMenuView(status: TasksStatus) -> some View {
        
        Menu {
            Button {
                withAnimation {
                    self.currentStatus = .all
                }
            } label: {
                
                Text("All")
                if status == .all {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            Button {
                withAnimation {
                    self.currentStatus = .completed
                }
            } label: {
                Text("Completed")
                if status == .completed {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            
            Button {
                withAnimation {
                    self.currentStatus = .incompleted
                }
            } label: {
                Text("Incompleted")
                if status == .incompleted {
                    Image(systemName: "checkmark.circle.fill")
                }
                
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.square")
                .font(.title3)
                .foregroundColor(Color.secondary)
                .shadow(radius: 4)
            
            
        }.foregroundColor(.primary)
    }
}

