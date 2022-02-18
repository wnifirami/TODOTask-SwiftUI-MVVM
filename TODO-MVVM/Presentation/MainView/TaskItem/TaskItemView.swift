//
//  TaskItemView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 16/2/2022.
//

import SwiftUI

struct TaskItemView: View {
    @State private var stroken = false
    let viewModel: TaskItemViewModel
    init(
        viewModel: TaskItemViewModel
    ) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    self.stroken.toggle()
                } label: {
                    Image(systemName: stroken ? "circle.fill" : "circle")
                }
                .shadow(color: .secondary, radius: 2, x: 0, y: 1)

                VStack(alignment: .leading) {
                    Text(viewModel.item.datumDescription)
                         .font(.footnote)
                         .fontWeight(.regular)
                         .foregroundColor(.primary)
                         .strikethrough(stroken)

                }
                Spacer()
            }
            .shadow(color: .secondary, radius: 2, x: 0, y: 1)
            .padding(.horizontal)

            
        }
        
        .frame(height: 80, alignment: .center)
        .background(ColorConstants.yellowColor.opacity(0.6))

    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(viewModel: TaskItemViewModel(item: Task(completed: true, id: "1", datumDescription: "Reading bool", owner: "620ba23b957bd000171c39a3", createdAt: "2022-02-16T13:53:02.858Z", updatedAt: "2022-02-16T13:53:02.858Z", v: 2)))
    }
}
