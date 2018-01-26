//
//  RoundButton.swift
//  Calculator
//
//  Created by 주호박 on 2018. 1. 26..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

// Class Attribute??
// IBDesignable이란 속성은 prepareForInterfaceBuilder
@IBDesignable
class RoundButton: UIButton {

    //Declarlation Attribute??
    @IBInspectable var roundButton: Bool = false {
        didSet{
            
            if roundButton {
            
                layer.cornerRadius = frame.height / 2
                
            }
            
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        if roundButton{
            layer.cornerRadius = frame.height / 2
        }
    }
    
}
