//
//  ViewController.swift
//  Calculator
//
//  Created by 주호박 on 2018. 1. 26..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //
    
    
    
    @IBOutlet weak var resultLb: UILabel!
    var numTemp: String = ""
    var outputTemp: String = ""
    var oper: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }

   
    @IBAction func clickButton(_ sender: RoundButton){
        
        if sender.tag <= 9 && sender.tag >= 0{
            
            numTemp += String(sender.tag)
        }
    
    }

    @IBAction func clickOper(_ sender: RoundButton){
        
        if sender.titleLabel!.text == "=" && oper != ""{// 결과값 구해야 하는 경우.
            
        }
        
        switch sender.titleLabel!.text {
        case "+":
            <#code#>
        default:
            <#code#>
        }
        
    }
    
    @IBAction func allClear(_ sender: RoundButton) {
    
        
    }
    
    
    
    
    
    
}

