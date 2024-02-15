//
//  HWListView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

struct AssignmentsView: View {
    @EnvironmentObject var userData: UserData
    @State var selectedDate = Date.now
    @State private var sortType = "All"
    
    // used in filteredAssignments as a check if the users selectedDate is the future
    var selectedDateIsFuture: Bool {
        selectedDate.formatted(date: .abbreviated, time: .omitted) == Calendar.current.date(byAdding: .day, value: 7, to: Date.now)?.formatted(date: .abbreviated, time: .omitted)
    }
    
    var filteredAssignments: [Assignment] {
        if sortType == "Due Date" {
            if selectedDateIsFuture {
                userData.assignments.filter { $0.dueDate >= selectedDate }
            } else {
                userData.assignments.filter { $0.dueDate.formatted(date: .abbreviated, time: .omitted) == selectedDate.formatted(date: .abbreviated, time: .omitted) }
            }
        } else if sortType == "Today" {
            // sends back only the assignments that are due today
            userData.assignments.filter { $0.dueDate.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted) }
        } else {
            // if the sort type is anything other than "Due Date" or "Today", just send back all the stored assignments for now
            userData.assignments
        }
    }
    
    var totalEstimatedTime: String {
        var hoursSum = 0
        var minutesSum = 0
        
        for assignment in filteredAssignments {
            hoursSum += assignment.estimatedCompletionTimeHours
            minutesSum += assignment.estimatedCompletionTimeMinutes
        }
        
        hoursSum += (minutesSum / 60)
        minutesSum = Int(round(((Double(minutesSum) / 60) - Double(minutesSum / 60)) * 60))
        
        if hoursSum == 0 && minutesSum == 0 {
            return "No homework today!"
        } else if hoursSum == 0 {
            return "Total is \(minutesSum) min"
        } else if minutesSum == 0 {
            return ("Total is \(hoursSum) ") + (hoursSum == 1 ? "hour" : "hours")
        } else {
            return ("total is \(hoursSum) ") + (hoursSum == 1 ? "hour" : "hours") + (" \(minutesSum) min")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("", selection: $sortType) {
                    Text("All").tag("All")
                    
                    Text("Class").tag("Class")
                    
                    Text("Due Date").tag("Due Date")
                    
                    Text("Today").tag("Today")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text(totalEstimatedTime)
                
                if sortType == "Due Date" {
                    DateScrollView(selectedDate: $selectedDate)
                }
                
                ForEach(filteredAssignments.sorted { $0.dueDate < $1.dueDate }) { assignment in
                    NavigationLink {
                        AssignmentDetailView(assignment: assignment, assignmentIndex: getAssignmentIndex(assignment: assignment))
                    } label: {
                        HStack {
                            if assignment.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.headline)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.black)
                                    .font(.headline)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(assignment.subject.uppercased())
                                    .bold()
                                
                                Text(assignment.title)
                            }
                            
                            Spacer()
                            
                            Text(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                userData.assignments[getAssignmentIndex(assignment: assignment)].isCompleted = true
                            } label: {
                                Image(systemName: "checkmark")
                                    .font(.headline)
                            }
                            .tint(.green)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                userData.assignments[getAssignmentIndex(assignment: assignment)].isCompleted = false
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.headline)
                            }
                            .tint(.black)
                        }
                    }
                }
                .padding(.vertical)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("HWTracker")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddAssignmentView(subjectName: userData.classes.isEmpty ? "" : userData.classes[0].name)
                            .environmentObject(userData)
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func getAssignmentIndex(assignment: Assignment) -> Int {
        // figure out a better response if index can't be found
        guard let assignmentIndex = userData.assignments.firstIndex(where: { $0.id == assignment.id }) else { return 0 }
        return assignmentIndex
    }
}

#Preview {
    AssignmentsView()
}
