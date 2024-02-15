//
//  Assignment.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

struct Assignment: Codable, Identifiable {
    var id = UUID()
    var title: String
    var dueDate: Date
    var subject: String
    var estimatedCompletionTimeHours: Int
    var estimatedCompletionTimeMinutes: Int
    var isCompleted: Bool
    
    static let example = Assignment(title: "Written Homework", dueDate: Date.now, subject: "Spanish", estimatedCompletionTimeHours: 0, estimatedCompletionTimeMinutes: 30, isCompleted: false)
}
