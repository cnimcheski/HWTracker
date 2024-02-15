//
//  ContentView.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userData = UserData()
    
    var body: some View {
        TabView {
            Group {
                AssignmentsView()
                    .tabItem {
                        Label("HW", systemImage: "newspaper")
                    }
            }
            .environmentObject(userData)
            .toolbarBackground(.yellow, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
