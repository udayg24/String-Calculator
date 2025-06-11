//
//  ContentView.swift
//  String Calculator
//
//  Created by Uday Gajera on 10/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var additionResult: Int = 0
    @State private var errorMessage: String = ""
    private let calculator = Calculator()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.title)
                .padding()
            
            TextEditor(text: $inputText)
                .border(Color.gray, width: 2)
                .frame(maxHeight: 100)
                .padding()
            
            Button("Calculate Sum") {
                errorMessage = ""
                do {
                    additionResult = try calculator.add(inputText)
                } catch let error as CalculatorError {
                    errorMessage = error.localizedDescription
                    additionResult = 0
                } catch {
                    errorMessage = "Unexpected error occurred"
                    additionResult = 0
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Result: \(additionResult)")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
