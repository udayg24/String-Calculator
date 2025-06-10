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
        return Int(numbers) ?? 0
    }
}
