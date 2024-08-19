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
            HStack {
                Button {
                    date.decrementMonth()
                } label: {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(date.monthName())
                    .font(.title2)
                    .fontDesign(.rounded)
                    .bold()


                Spacer()

                Button {
                    date.incrementMonth()
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundStyle(.white)
            .padding()

            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : .clear
                                    )
                            )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .background(RoundedRectangle(cornerRadius: 24)
            .fill(Color(.purple)))
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
}

#Preview {
    CalendarView()
        .padding()
}
