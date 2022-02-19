//
//  AddTaskView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 19/2/2022.
//

import SwiftUI

struct AddTaskView: View {
    @State private var description: String = ""
    @State private var completed: Bool = false

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Task for Today")
                        .font(.body)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                    
                    } label: {
                        HStack {
                            Image(systemName: "checkmark" )
                                .font(.body)
                                .foregroundColor(.blue)
                            Text("Done")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        .padding()
                     
                    }

                }
                .padding()
                Divider()
                TextField("Describe your task", text: $description)
                    .frame( height: 200, alignment: .center)
                    .padding()
                Divider()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            completed.toggle()
                        }
                    } label: {
                        Image(systemName: completed ? "circle.fill" : "circle")
                        Text("Completed")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding()
            }
            .background(ColorConstants.darkYellowColor)
            .padding()
        .shadow(color: .secondary, radius: 2, x: 0, y: 1)
            
     
        }
      
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
