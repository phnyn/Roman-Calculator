//
//  ContentView.swift
//  RomanCalculator
//
//  Created by Phuong  Nguyen on 29.06.22.
//

import SwiftUI

let gradientA = Color(UIColor(red:116/255, green:188/255, blue: 229/255, alpha: 0.5))
let gradientB = Color(UIColor(red:178/255, green:221/255, blue: 173/255, alpha: 1.0))
let primaryBG = LinearGradient(gradient: Gradient(colors: [gradientA, gradientB]), startPoint: .leading, endPoint: .topTrailing)
let secondaryBG = Color(UIColor(red:209/255, green: 228/255, blue: 209/255, alpha: 0.7))
let lightbtn = Color(UIColor(red: 209/255, green: 228/255, blue: 209/255, alpha: 0.7))
let darkbtn = Color(UIColor(red: 194/255, green: 219/255, blue: 193/255, alpha: 0.7))

enum Btn: String {
    case i = "I"
    case v = "V"
    case x = "X"
    case l = "L"
    case c = "C"
    case d = "D"
    case m = "M"
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    case equal = "="
    case del = "DEL"
    case ac = "AC"
    case empty = " "

    var btnColor: Color {
        switch self{
        case .add, .sub, .div, .equal, .del, .mul, .ac:
            return darkbtn
        default:
            return lightbtn
        }
    }
}

let rows : [[Btn]] = [
    [.ac , .del, .div, .mul],
    [.i,.v,.x, .sub],
    [.l ,.c , .d , .add],
    [.m , .equal]
]

struct ContentView: View {
    
    @State var finalValue:String = "0"
    @State var operationTxt: String = " "
    @State var operation: Btn = .empty
    @State var userInput: [String] = []
    let roman = RomanCalculator()
    @State var equals = false
    
    var body: some View {
        VStack{
            //Top
            VStack{
                Spacer(minLength: 3)

                Text(operationTxt)
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                
                Spacer(minLength: 0.5)

                Text(finalValue)
                    .bold()
                    .font(.system(size: 50))
                    .foregroundColor(.black)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .bottomTrailing)
            .padding()
            
            //bottom
            VStack{
                VStack{
                    VStack {
                        ForEach(rows, id: \.self) { row in
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(row, id: \.self) { btn in
                                    Button(action: {
                                        self.tap(button: btn)
                                    }, label: {
                                        Text(btn.rawValue)
                                            .bold()
                                            .frame(minWidth: 10, idealWidth: 10 , maxWidth: .infinity, minHeight: 10, idealHeight: 50, maxHeight: 80, alignment: .center)
                                    })
                                    .foregroundColor(.black)
                                    .background(btn.btnColor)
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }
            .background(secondaryBG)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 1000, alignment: .bottomLeading)
        }
        .background(primaryBG)
    }
    
    func tap(button: Btn){
        switch button {
        case .add, .sub, .mul, .div:
            if equals == true{
                clear()
            }
            
            if(userInput.count < 2 && operation == .empty){
                if self.finalValue != "0" {
                    self.userInput.append(self.finalValue)
                    self.operationTxt += self.finalValue + button.rawValue
                    self.operation = button
                    self.finalValue = ""
                }
            }
            break;
            
        case .equal:
            if self.finalValue != " " {
                self.userInput.append(self.finalValue)
                self.operationTxt += self.finalValue + " = "
                self.finalValue = calculate()
                self.equals = true
            }
            break;
            
        case .ac:
            clear()
            break;
            
        case .del:
            if equals == false{
                self.finalValue.removeLast()
            }
            break;
            
        default:
            let number = button.rawValue
            if self.finalValue == "0" {
                self.finalValue = number
            } else {
                if(equals == true){
                    clear()
                    self.finalValue = ""
                }
                self.finalValue = "\(self.finalValue)\(number)"
            }
            break;
        }
    }
    
    func clear() {
        self.operationTxt = " "
        self.operation = .empty
        self.finalValue = "0"
        self.userInput = []
        self.equals = false;
    }
    
    func calculate() -> String{
        let x = userInput[0]
        let y = userInput[1]
        let op = Character(operation.rawValue)
        return roman.calculate(numberA: x, method: op, numberB: y)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
