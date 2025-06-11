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
    @FocusState private var isTextFieldFocused: Bool
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
        VStack(spacing: 8) {
            Text("String Calculator")
                .font(.system(size: 32, weight: .light, design: .rounded))
                .foregroundColor(.primary)
            
            Text("Add numbers with custom delimiters")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
    }
    
    private var TextEditorView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Input")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.leading, 4)
            
            TextField("Enter numbers (e.g., 1,2,3 or //;\n1;2;3)", text: $inputText, axis: .vertical)
                .focused($isTextFieldFocused)
                .padding(16)
                .background(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isTextFieldFocused ? Color.blue : Color(.systemGray4), lineWidth: 1.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .animation(.easeInOut(duration: 0.2), value: isTextFieldFocused)
        }
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
