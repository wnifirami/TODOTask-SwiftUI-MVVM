//
//  CalendarView.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 16/2/2022.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    
    init(date: Binding<Date>) {
        self._date = date
    }
  

    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
                .datePickerStyle(.graphical)
        }
        .padding()
        .background(Color(UIColor.systemBackground)
                        .cornerRadius(10)
        )
        .shadow(color: .secondary, radius: 2, x: 0, y: 1)
     
        .padding()
        

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
    }
}
