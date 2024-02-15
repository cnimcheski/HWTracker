//
//  AddAssignmentView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

struct AddAssignmentView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    @State private var subject = ""
    @State private var title = ""
    @State private var dueDate = Date.now
    @State private var estimatedCompletionTimeHours = 0
    @State private var estimatedCompletionTimeMinutes = 30
    @State private var isCompleted = false
    @State var subjectName: String
    
    var saveButtonDisabled: Bool {
        title.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // check if the user doesn't have any classes added yet
                if subjectName.isEmpty {
                    Text("You don't have any classes added yet, press the add a class button.")
                    
                    NavigationLink {
                        AddClassView(subjectName: $subjectName)
                            .environmentObject(userData)
                    } label: {
                        Text("Add A Class")
                            .customButtonStyle()
                    }
                } else {
                    HStack {
                        Picker("", selection: $subjectName) {
                            ForEach(userData.classes) { subject in
                                Text(subject.name).tag(subject.name)
                            }
                        }
                        .font(.headline)
                        .accentColor(.black)
                        
                        NavigationLink {
                            AddClassView(subjectName: $subjectName)
                                .environmentObject(userData)
                        } label: {
                            Text("Add A Class")
                                .customButtonStyle()
                        }
                    }
                }
                
                CustomTextFieldView(text: $title, prompt: "Title")
                
                VStack(alignment: .leading) {
                    Text("Due Date")
                        .font(.headline)
                    
                    DatePicker("", selection: $dueDate, displayedComponents: DatePickerComponents([.date]))
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
                VStack {
                    HStack {
                        Text("Estimated Completion Time")
                            .font(.headline)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Picker("", selection: $estimatedCompletionTimeHours) {
                            ForEach(0..<10) { hour in
                                Text(hour == 1 ? "1 hour" : "\(hour) hours").tag(hour)
                            }
                        }
                        
                        Picker("", selection: $estimatedCompletionTimeMinutes) {
                            Text("0 min").tag(0)
                            
                            ForEach(1..<4) { minute in
                                Text("\(minute * 15) min").tag(minute * 15)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Toggle("Completed", isOn: $isCompleted)
                    .font(.headline)
                
                Button {
                    saveAssignment()
                } label: {
                    Text("Add Assignment")
                        .customButtonStyle()
                        .opacity(saveButtonDisabled ? 0.8 : 1.0)
                }
                .disabled(saveButtonDisabled)
            }
            .padding()
            .accentColor(.yellow)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New Assignment")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(.yellow, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func saveAssignment() {
        let assignment = Assignment(title: title, dueDate: dueDate, subject: subjectName, estimatedCompletionTimeHours: estimatedCompletionTimeHours, estimatedCompletionTimeMinutes: estimatedCompletionTimeMinutes, isCompleted: isCompleted)
        userData.assignments.append(assignment)
        dismiss()
    }
}

#Preview {
    AddAssignmentView(subjectName: "Spanish")
}
