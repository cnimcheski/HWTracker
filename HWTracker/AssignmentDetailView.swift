//
//  AssignmentDetailView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

struct AssignmentDetailView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) var dismiss
    @State var assignment: Assignment
    let assignmentIndex: Int
    
    var updateButtonDisabled: Bool {
        assignment.title.isEmpty
    }
    
    var estimatedCompletionTime: String {
        if assignment.estimatedCompletionTimeHours == 0 {
            // as long as hours is equal to 0, we know that this text isn't even going to be shown if minutes is 0, so we can just send this back anyway
            "\(assignment.estimatedCompletionTimeMinutes) min"
        } else if assignment.estimatedCompletionTimeHours == 1 {
            if assignment.estimatedCompletionTimeMinutes == 0 {
                "1 hour"
            } else {
                "1 hour \(assignment.estimatedCompletionTimeMinutes) min"
            }
        } else {
            "\(assignment.estimatedCompletionTimeHours) hours \(assignment.estimatedCompletionTimeMinutes) min"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Class")
                        .font(.headline)
                    
                    Text(assignment.subject)
                }
                        
                Spacer().frame(height: 20)
                
                Group {
                    Text("Due Date")
                        .font(.headline)
                    
                    Text(userData.assignments[assignmentIndex].dueDate.formatted(date: .abbreviated, time: .omitted))
                }
                
                Spacer().frame(height: 20)
                
                if assignment.estimatedCompletionTimeHours != 0 || assignment.estimatedCompletionTimeMinutes != 0 {
                    // only show these views if hours and minutes aren't both 0
                    Group {
                        Text("Estimated Completion Time")
                            .font(.headline)
                        
                        Text(estimatedCompletionTime)
                    }
                }
                
                Spacer().frame(height: 20)
            
                CustomTextFieldView(text: $assignment.title, prompt: "Name")
                
                Spacer().frame(height: 20)
                
                Toggle("Completed", isOn: $assignment.isCompleted)
                    .font(.headline)
                
                Spacer().frame(height: 20)
                
                Button {
                    updateAssignment()
                } label: {
                    Text("Update")
                        .customButtonStyle()
                        .opacity(updateButtonDisabled ? 0.8 : 1.0)
                }
                .disabled(updateButtonDisabled)
            }
            .padding()
            .accentColor(.yellow)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(userData.assignments[assignmentIndex].title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(.yellow, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func updateAssignment() {
        // maybe not the best way...but works
        userData.assignments.remove(at: assignmentIndex)
        userData.assignments.append(assignment)
        dismiss()
    }
}

#Preview {
    AssignmentDetailView(assignment: Assignment.example, assignmentIndex: 0)
}
