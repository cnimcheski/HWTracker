//
//  AddClassView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/12/24.
//

import SwiftUI

struct AddClassView: View {
    @EnvironmentObject var userData: UserData
    @Binding var subjectName: String
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var saveButtonDisabled: Bool {
        name.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CustomTextFieldView(text: $name, prompt: "Name")
                
                Button {
                    saveClass()
                } label: {
                    Text("Add Class")
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
                Text("New Class")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(.yellow, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func saveClass() {
        subjectName = name
        let newClass = Subject(name: name)
        userData.classes.append(newClass)
        dismiss()
    }
}

#Preview {
    AddClassView(subjectName: .constant("Spanish"))
}
