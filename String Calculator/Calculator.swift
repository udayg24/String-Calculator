//
//  Calculator.swift
//  String Calculator
//
//  Created by Uday Gajera on 10/06/25.
//

import Foundation

class Calculator {
    
    func add(_ numbers: String) throws -> Int {
        guard !numbers.isEmpty else { return 0 }
        
        let normalizedNumbers = numbers.replacingOccurrences(of: "\\n", with: "\n")
        let (delimiter, numberString) = try extractDelimiterAndNumbers(from: normalizedNumbers)
        
        let components = numberString
            .replacingOccurrences(of: "\n", with: delimiter)
            .components(separatedBy: delimiter)
        
        let parsedNumbers = try parseNumbers(from: components)
        
        let negativeNumbers = parsedNumbers.filter { $0 < 0 }
        if !negativeNumbers.isEmpty {
            throw CalculatorError.negativeNumbers(negativeNumbers)
        }
        
        return parsedNumbers.reduce(0, +)
    }
    
    private func parseNumbers(from components: [String]) throws -> [Int] {
        var parsedNumbers: [Int] = []
        for component in components {
            let trimmed = component.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty, let number = Int(trimmed) else {
                throw CalculatorError.invalidInput
            }
            parsedNumbers.append(number)
        }
        return parsedNumbers
    }
    
    private func extractDelimiterAndNumbers(from input: String) throws -> (String, String) {
        guard input.hasPrefix("//") else {
            return (",", input)
        }
        
        let lines = input.components(separatedBy: "\n")     
        guard lines.count >= 2 else {
            throw CalculatorError.invalidInput
        }
        
        let delimiterLine = lines[0]
        guard delimiterLine.count > 2 else {
            throw CalculatorError.invalidInput
        }
        
        let delimiter = String(delimiterLine.dropFirst(2))
        guard delimiter.count == 1 else {
            throw CalculatorError.invalidInput
        }
        
        let numberString = lines[1...].joined(separator: "\n")
        return (delimiter, numberString)
    }
}

enum CalculatorError: Error, Equatable {
    case negativeNumbers([Int])
    case invalidInput
    
    var localizedDescription: String {
        switch self {
        case .negativeNumbers(let numbers):
            let numberList = numbers.map(String.init).joined(separator: ",")
            return "negative numbers not allowed \(numberList)"
        case .invalidInput:
            return "invalid input"
        }
    }
}
