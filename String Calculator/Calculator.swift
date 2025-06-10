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
        
        let (delimiter, numberString) = extractDelimiterAndNumbers(from: numbers)
        
        let parsedNumbers = numberString
            .replacingOccurrences(of: "\n", with: delimiter)
            .components(separatedBy: delimiter)
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        
        let negativeNumbers = parsedNumbers.filter { $0 < 0 }
        if !negativeNumbers.isEmpty {
            throw CalculatorError.negativeNumbers(negativeNumbers)
        }
        
        return parsedNumbers.reduce(0, +)
    }

    private func extractDelimiterAndNumbers(from input: String) -> (String, String) {
        guard input.hasPrefix("//") else {
            return (",", input)
        }
        
        let lines = input.components(separatedBy: "\n")
        guard lines.count >= 2 else {
            return (",", input)
        }
        
        let delimiter = String(lines[0].dropFirst(2))
        let numberString = lines[1...].joined(separator: "\n")
        return (delimiter, numberString)
    }
}

enum CalculatorError: Error, Equatable {
    case negativeNumbers([Int])
    
    var localizedDescription: String {
        switch self {
        case .negativeNumbers(let numbers):
            let numberList = numbers.map(String.init).joined(separator: ",")
            return "negative numbers not allowed \(numberList)"
        }
    }
}
