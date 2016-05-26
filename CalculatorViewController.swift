//
//  ViewController.swift
//  Calculator
//
//  Created by Cesar Ibarra on 5/16/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var display: UILabel!
    private var userInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            if let contents = display.text {
                brain.description.appendContentsOf(contents)
            }
        }
        else {
            display.text = digit
            if let contents = display.text {
                brain.description.appendContentsOf(contents)
            }
        }
        userInTheMiddleOfTyping = true
        setDescription()
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol != "=" {
                brain.description.appendContentsOf(mathematicalSymbol)
            }
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        setDescription()
    }
    
    private func setDescription() {
        descriptionLabel.text = brain.description
    }
}

