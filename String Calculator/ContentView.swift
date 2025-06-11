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
    @State private var isCalculating: Bool = false
    private let calculator = Calculator()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            ZStack {
                VStack(spacing: 20) {
                    HeadlineTextView
                    
                    VStack(spacing: 24) {
                        TextEditorView
                        CalculateButtonView
                    }
                    
                    ResultView
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.regularMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .background(
            LinearGradient(
                colors: [Color(.systemBackground), Color(.systemGray3)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}
extension ContentView {
    
    private var HeadlineTextView: some View {
        VStack(spacing: 8) {
            Text("String Calculator")
                .font(.system(size: 32, weight: .medium, design: .rounded))
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
                .font(.system(size: 16, weight: .medium, design: .rounded))
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
        Button(action: performCalculation) {
            HStack(spacing: 8) {
                if isCalculating {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(.white)
                } else {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 18, weight: .medium))
                }
                
                Text("Calculate")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                LinearGradient(
                    colors: [Color.blue, Color.blue.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .scaleEffect(isCalculating ? 0.90 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isCalculating)
        }
        .disabled(isCalculating || inputText.trimmingCharacters(in: .whitespaces).isEmpty)
        .opacity(inputText.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: inputText.isEmpty)
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
    
    private func performCalculation() {
        isTextFieldFocused = false
        errorMessage = ""
        additionResult = nil
        isCalculating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            do {
                additionResult = try calculator.add(inputText)
            } catch let error as CalculatorError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = "Unexpected error occurred"
            }
            isCalculating = false
        }
    }
}
#Preview {
    ContentView()
}
