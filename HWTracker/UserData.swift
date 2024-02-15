//
//  HWListViewModel.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

@MainActor class UserData: ObservableObject {
    let assignmentsSavePath = FileManager.documentsDirectory.appendingPathComponent("Assignments")
    let classesSavePath = FileManager.documentsDirectory.appendingPathComponent("Classes")
    
    @Published var assignments: [Assignment] = [] {
        didSet {
            // save assignments
            let encoder = JSONEncoder()
            
            do {
                let encodedAssignments = try encoder.encode(assignments)
                try encodedAssignments.write(to: assignmentsSavePath, options: [.atomic])
            } catch {
                print("Error saving assignments: \(error.localizedDescription)")
            }
        }
    }
    
    @Published var classes: [Subject] = [] {
        didSet {
            // save classes
            let encoder = JSONEncoder()
            
            do {
                let encodedClasses = try encoder.encode(classes)
                try encodedClasses.write(to: classesSavePath, options: [.atomic])
            } catch {
                print("Error saving classes: \(error.localizedDescription)")
            }
        }
    }
    
    init() {
        // load assignments
        let decoder = JSONDecoder()
        
        do {
            let assignmentsData = try Data(contentsOf: assignmentsSavePath)
            let decodedAssignments = try decoder.decode([Assignment].self, from: assignmentsData)
            assignments = decodedAssignments
        } catch {
            print("Error retrieving assignments: \(error.localizedDescription)")
            assignments = []
        }
        
        do {
            let classesData = try Data(contentsOf: classesSavePath)
            let decodedClasses = try decoder.decode([Subject].self, from: classesData)
            classes = decodedClasses
        } catch {
            print("Error retrieving classes: \(error.localizedDescription)")
        }
    }
}
