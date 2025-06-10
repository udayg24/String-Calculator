//
//  Calculator.swift
//  String Calculator
//
//  Created by Uday Gajera on 10/06/25.
//

import Foundation

class Calculator {
    
    func add(_ numbers: String) -> Int {
        guard !numbers.isEmpty else {
            return 0
        }
        var delimiter = ","
        var numberString = numbers
        if numberString.hasPrefix("//") {
            let parts = numberString.components(separatedBy: "\n")
            if parts.count >= 2 {
                delimiter = String(parts[0].dropFirst(2))
                numberString = parts[1...].joined(separator: "\n")
            }
        }
        let parts = numberString.replacingOccurrences(of: "\n", with: delimiter)
                                .components(separatedBy: delimiter)
        
        return parts.compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }.reduce(0, +)
    }
}
