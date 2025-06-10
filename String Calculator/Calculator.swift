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
        let parts = numbers.components(separatedBy: CharacterSet(charactersIn: ",\n"))
        return parts.compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }.reduce(0, +)
    }
}
