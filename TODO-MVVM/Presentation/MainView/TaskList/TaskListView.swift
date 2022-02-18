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
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    @State var currentStatus: TasksStatus = .all
    @ObservedObject var viewModel: TaskListViewModel
    init(viewModel: TaskListViewModel) {
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
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
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
    @ViewBuilder private func createList() -> some View {
        Group {

            VStack {


                ScrollView( .vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(viewModel.filterAssignment(status: currentStatus)) { item in
                               TaskItemView(viewModel: TaskItemViewModel(item: item))
                            }// loop
                        }//: Grid
                        .padding(10)
                        .animation(.easeIn)
                }
            }//: scroll
        }// : Group
    }
        
        func gridSwitch() {
            gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
            gridColumn = gridLayout.count
            print ("grid number", gridColumn)
            switch gridColumn {
            case 1: toolbarIcon = "square.grid.2x2.fill"
            case 2:  toolbarIcon = "square.grid.3x2.fill"
            case 3:  toolbarIcon = "rectangle.grid.1x2.fill"
            default:  toolbarIcon = "square.grid.2x2.fill"
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

