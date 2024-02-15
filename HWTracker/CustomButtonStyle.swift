//
//  CustomButtonStyle.swift
//  HWTracker
//
//  Created by Steve Nimcheski on 2/12/24.
//

import SwiftUI

struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .contentShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func customButtonStyle() -> some View {
        modifier(CustomButtonStyle())
    }
}
