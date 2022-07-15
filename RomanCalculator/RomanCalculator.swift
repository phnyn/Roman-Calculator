//
//  RomanCalculator.swift
//  RomanCalculator
//
//  Created by Phuong  Nguyen on 14.07.22.
//

import Foundation

class RomanCalculator {
    let pattern = #"^M*(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$"#
    let numbers = [ "I": 1, "V": 5, "X": 10, "L":50, "C": 100, "D": 500, "M": 1000]
    let method = "+-*/"

    func validateCharacter(number: String)-> Bool{
        let num = number.uppercased();
        let result = num.range(of: pattern, options: .regularExpression)

        if(result != nil){
            return true
        } else {
            print("\(number) is invalid. Try again.")
            return false
        }
    }

    func validateMethod(symbol: Character) -> Bool{
        if(method.contains(symbol)){
            return true
        } else {
            print("\(symbol) is invalid only use +,-,* or /");
            return false
        }
    }
    
    func translateRoman(number: String)-> Int{
        let text = number.uppercased()
        var numArray = [Int]()
        var negation = 0

        for symbol in text{
            numArray.append(numbers[String(symbol)]!)
        }

        var i = 0
        while(i < numArray.count - 1){
            if(numArray[i] < numArray[i+1]){
                negation += numArray[i]
            }
            i += 1
        }
        let sum = numArray.reduce(0,+) - 2*negation
        return sum
    }
    
    func add (x: String, y: String) -> Int {
        return (translateRoman(number: x) + translateRoman(number: y))
    }
    
    func subract (x: String, y: String) -> Int{
        return (translateRoman(number: x) - translateRoman(number: y))
    }
    
    func multiply (x: String, y: String) -> Int {
        return (translateRoman(number: x) * translateRoman(number: y))
    }
    
    func divide (x: String, y: String) -> Double{
        return (Double(translateRoman(number: x)) / Double(translateRoman(number: y)))
    }
    
    func calculate(numberA: String, method: Character, numberB: String) -> String{
        var result = "Invalid";
        if(validateCharacter(number: numberA) && validateMethod(symbol: method) && validateCharacter(number: numberB) ){
            switch(method){
            case "+": result = String(add(x: numberA, y: numberB));
            case "-": result = String(subract(x: numberA, y: numberB));
            case "*": result = String(multiply(x: numberA, y: numberB));
            default: result = String(divide(x: numberA, y: numberB));
            }
        }
        return result
    }
}
