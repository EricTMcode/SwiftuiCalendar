//
//  ContentView.swift
//  SwiftuiCalendar
//
//  Created by Eric on 18/08/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    @State private var date = Date.now
    let daysOfWeek = ["M", "T", ]

    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }
        }
        .padding()
    }
}

#Preview {
    CalendarView()
}
