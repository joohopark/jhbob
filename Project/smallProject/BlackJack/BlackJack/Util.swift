//
//  Util.swift
//  BlackJack
//
//  Created by 주호박 on 2018. 2. 19..
//  Copyright © 2018년 주호박. All rights reserved.
//

import Foundation

class Util{
    var isLegnth8 = false
    var isIncludeSpecialChar = false
    var isIncludeUpperrChar = false
    var isIncludeLowerChar = false
    
    func passwordVerify(pw: String){
        //들어온 password가 8글자 이상
        if pw.count >= 8{
            isLegnth8 = true
        }
        //들어온 password가 특수문자 포함
        //들어온 password가 대소문자 포함
//        [A-Z0-9a-z.-_]
        for char in pw{
            switch char{
            case "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
                 "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z":
                isIncludeUpperrChar = true
            case "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
                 "q", "r", "s", "t", "u", "v", "w", "x", "y", "z":
                isIncludeLowerChar = true
            case "~","!","@","#","$","%","^","&","*","(",")","-","_","+","=","?",":",";","{":
                isIncludeSpecialChar = true
            default:
                print("pw verifying fail...")
                print("소문자 : \(isIncludeLowerChar)", "대문자 : \(isIncludeUpperrChar)", "특수문자 : \(isIncludeSpecialChar)","길이 : \(isLegnth8)" )
            }
        }
        
    }
}
