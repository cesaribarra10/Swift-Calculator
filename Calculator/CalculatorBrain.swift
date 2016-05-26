//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Cesar Ibarra on 5/17/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    //githubtest
    private var accumalator = 0.0
    private var pending: pendingBinaryOperationInfo?
    var description = ""
    typealias PropertyList = AnyObject
    private var internalProgram = [AnyObject]()
    
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    }
                    else if let operation = op as? String {
                        performOperation(operation)
                    }
                }
            }
        }
    }
    
    func setOperand(operand: Double) {
        accumalator = operand
        internalProgram.append(operand)
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "ln": Operation.UnaryOperation({log($0)}),
        "×" : Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 * op2 }),
        "÷" : Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 / op2 }),
        "+" : Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in return op1 + op2 }),
        "−" : Operation.BinaryOperation( { $0 - $1 } ),
        "∧" : Operation.BinaryOperation({ pow($0, $1) }),
        "=" : Operation.Equals,
        "C" : Operation.Clear
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    }
    
    func performOperation(symbol: String) {
        internalProgram.append(symbol)
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumalator = value
            case .UnaryOperation(let function):
                accumalator = function(accumalator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumalator)
            case .Equals:
                executePendingBinaryOperation()
            case .Clear:
                clear()
                description = ""
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumalator = pending!.binaryFunction(pending!.firstOperand, accumalator)
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumalator
        }
    }
    
    private struct pendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private func clear() {
        accumalator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
}