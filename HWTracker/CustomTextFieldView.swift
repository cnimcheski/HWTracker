//
//  CustomTextFieldView.swift
//  Budget
//
//  Created by Steve Nimcheski on 2/9/24.
//

import SwiftUI

//struct CustomTextFieldView: View {
//    @Binding var text: String {
//        // this doesn't work
//        didSet {
//            if text.count > 15 && oldValue.count <= 15 {
//                text = oldValue
//            }
//        }
//    }
//    let prompt: String
//    var maxLetterAmount: Int? = nil
//    var unwrappedMaxLetterAmount: Int {
//        maxLetterAmount ?? 5
//    }
//    
//    // animation properties
////    @State private var isTapped = false
//    
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading, spacing: 4) {
//                TextField("", text: $text) { status in
//                    // when TextField is clicked
////                    if status {
////                        // moving the prompt to the top
////                        withAnimation(.easeIn) {
////                            isTapped = true
////                        }
////                    }
//                } onCommit: {
//                    // when the return button is pressed...but only if no text typed
////                    if text.isEmpty {
////                        withAnimation(.easeOut) {
////                            isTapped = false
////                        }
////                    }
//                }
//                .onChange(of: text) { oldValue, newValue in
//                    if maxLetterAmount != nil {
//                        if newValue.count > unwrappedMaxLetterAmount {
//                            text = oldValue
//                        }
//                    }
//                }
//                .padding(.top, 15)
//                .background(
//                    Text(prompt)
//                        .scaleEffect(0.8)
//                        .offset(x: -7, y: -15)
//                        .foregroundColor(.accentColor)
//                    
//                    ,alignment: .leading
//                )
//                .padding(.horizontal)
//                
//                // divider
//                Rectangle()
//                    .fill(Color.accentColor)
//                    .opacity(1)
//                    .frame(height: 1)
//                    .padding(.top, 10)
//            }
//            .padding(.top, 12)
//            .background(Color.gray.opacity(0.09))
//            .cornerRadius(5)
//            
//            // displaying letter count...optional
//            if maxLetterAmount != nil {
//                HStack {
//                    Spacer()
//                    
//                    Text("\(text.count)/\(unwrappedMaxLetterAmount)")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        .padding(.trailing)
//                        .padding(.top, 4)
//                }
//            }
//        }
//    }
//    
//    // gives the isTapped an initial value depending on if the text is empty
//    init(text: Binding<String>, prompt: String) {
//        self.prompt = prompt
//        
//        _text = text
//        
////        if self.text.isEmpty {
////            _isTapped = State(initialValue: false)
////        } else {
////            _isTapped = State(initialValue: true)
////        }
//    }
//    
//    // this initializer does the some as the one above but also allows for a max letter amount to be inputted
//    init(text: Binding<String>, prompt: String, maxLetterAmount: Int?) {
//        self.prompt = prompt
//        self.maxLetterAmount = maxLetterAmount
//        
//        _text = text
//        
////        if self.text.isEmpty {
////            _isTapped = State(initialValue: false)
////        } else {
////            _isTapped = State(initialValue: true)
////        }
//    }
//}

struct CustomTextFieldView: View {
    @Binding var text: String {
        // this doesn't work
        didSet {
            if text.count > 15 && oldValue.count <= 15 {
                text = oldValue
            }
        }
    }
    let prompt: String
    var maxLetterAmount: Int? = nil
    var unwrappedMaxLetterAmount: Int {
        maxLetterAmount ?? 5
    }

    // animation properties
    @State private var isTapped = false

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                TextField("", text: $text) { status in
                    // when TextField is clicked
                    if status {
                        // moving the prompt to the top
                        withAnimation(.easeIn) {
                            isTapped = true
                        }
                    }
                } onCommit: {
                    // when the return button is pressed...but only if no text typed
                    if text.isEmpty {
                        withAnimation(.easeOut) {
                            isTapped = false
                        }
                    }
                }
                .onChange(of: text) { oldValue, newValue in
                    if maxLetterAmount != nil {
                        if newValue.count > unwrappedMaxLetterAmount {
                            text = oldValue
                        }
                    }
                }
                .padding(.top, isTapped ? 15 : 0)
                .background(
                    Text(prompt)
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? .accentColor : .gray)

                    ,alignment: .leading
                )
                .padding(.horizontal)

                // divider
                Rectangle()
                    .fill(isTapped ? Color.accentColor : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 1)
                    .padding(.top, 10)
            }
            .padding(.top, 12)
            .background(Color.gray.opacity(0.09))
            .cornerRadius(5)

            // displaying letter count...optional
            if maxLetterAmount != nil {
                HStack {
                    Spacer()

                    Text("\(text.count)/\(unwrappedMaxLetterAmount)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .padding(.top, 4)
                }
            }
        }
    }

    // gives the isTapped an initial value depending on if the text is empty
    init(text: Binding<String>, prompt: String) {
        self.prompt = prompt

        _text = text

        if self.text.isEmpty {
            _isTapped = State(initialValue: false)
        } else {
            _isTapped = State(initialValue: true)
        }
    }

    // this initializer does the some as the one above but also allows for a max letter amount to be inputted
    init(text: Binding<String>, prompt: String, maxLetterAmount: Int?) {
        self.prompt = prompt
        self.maxLetterAmount = maxLetterAmount

        _text = text

        if self.text.isEmpty {
            _isTapped = State(initialValue: false)
        } else {
            _isTapped = State(initialValue: true)
        }
    }
}

#Preview {
    CustomTextFieldView(text: .constant("username"), prompt: "Username")
}
