//
//  DateScrollView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/13/24.
//

import SwiftUI

struct DateScrollView: View {
    @Binding var selectedDate: Date
    @State private var dateArray: [Date] = []
    
    // used to ensure the scrollview isn't duplicated
    @State private var isFirstShown = true
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<dateArray.count, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(dayFromDate(date: selectedDate) == dayFromDate(date: dateArray[index]) ? .yellow : .gray.opacity(0.2))
                        
                        Group {
                            if index == 7 {
                                Text("Future")
                                    .bold()
                            } else {
                                VStack {
                                    Text(dayFromDate(date: dateArray[index]))
                                        .font(.title2.bold())
                                    
                                    Text(dayOfWeekFromDate(date: dateArray[index]))
                                        .bold()
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: 80, height: 90)
                    .onTapGesture {
                        selectedDate = dateArray[index]
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .onAppear {
            if isFirstShown {
                for index in 0..<8 {
                    if let nextDay = Calendar.current.date(byAdding: .day, value: index, to: Date.now) {
                        dateArray.append(nextDay)
                    }
                }
                
                isFirstShown = false
            }
        }
    }
    
    func dayFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func dayOfWeekFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    DateScrollView(selectedDate: .constant(Date.now))
}
