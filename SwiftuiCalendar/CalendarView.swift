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
    @State private var days: [Date] = []

    let daysOfWeek = Date.capitalizedFirstLetterOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
            LabeledContent("Date/Time") {
                DatePicker("", selection: $date)
            }

            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    Text(day.formatted(.dateTime.day()))
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            Circle()
                                .foregroundStyle(color.opacity(0.3))
                        )
                }
            }

        }
        .padding()
    }
}

#Preview {
    CalendarView()
}
