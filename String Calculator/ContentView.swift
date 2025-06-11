//
//  ContentView.swift
//  String Calculator
//
//  Created by Uday Gajera on 10/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var additionResult: Int?
    @State private var errorMessage: String = ""
    private let calculator = Calculator()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            HeadlineTextView
            
            TextEditorView
                .font(.title3)
                .fontWeight(.regular)
            
            CalculateButtonView
                .font(.title)
                .fontWeight(.regular)
            
            ResultView
        }
    }
}
extension ContentView {
    
    private var HeadlineTextView: some View {
        Text("String Calculator")
            .font(.largeTitle)
            .fontWeight(.medium)
            .padding()
    }
    
    private var TextEditorView: some View {
        TextEditor(text: $inputText)
            .border(Color.gray, width: 2)
            .frame(maxHeight: 100)
            .padding()
    }
    
    private var CalculateButtonView: some View {
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
        .buttonStyle(.borderedProminent)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
    
    private var ResultView: some View {
        Group {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if let res = additionResult {
                Text("Result: \(res)")
                    .font(.headline)
                    .padding()
            }
        }
    }
}
#Preview {
    ContentView()
}
