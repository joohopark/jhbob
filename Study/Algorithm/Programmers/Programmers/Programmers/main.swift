//
//  main.swift
//  Programmers
//
//  Created by 주호박 on 2017. 11. 7..
//  Copyright © 2017년 주호박. All rights reserved.
//

import Foundation
//: Playground - noun: a place where people can play

// 문제의 메소드 구현은 그냥 함수 구현으로 대체.

//reverseStr 메소드는 String형 변수 str을 매개변수로 입력받습니다.
//str에 나타나는 문자를 큰것부터 작은 순으로 정렬해 새로운 String을 리턴해주세요.
//str는 영문 대소문자로만 구성되어 있으며, 대문자는 소문자보다 작은 것으로 간주합니다.
//예를들어 str이 "Zbcdefg"면 "gfedcbZ"을 리턴하면 됩니다.


//func reverseStr(str: String) -> String{
//
//    var temp: String =  ""
//
//    if
//
//
//
//
//    return "d"
//
//}


//sum_digit함수는 자연수를 전달 받아서 숫자의 각 자릿수의 합을 구해서 return합니다.
//예를들어 number = 123이면 1 + 2 + 3 = 6을 return하면 됩니다.
//sum_digit함수를 완성해보세요.


// 입력한 숫자를 한자리씩 때기 위해서는
//1. 10씩 증가하는 값으로 입력 값을 반복하여 나눠 1이상이 되는 경우에.
//2. 10씩 증가하는 값으로 입력 값의 나머지 연산하여 마지막 값을 떼어내서 결과 변수에 더한다.
//3. 입력값- 떼어낸 값으로 변경 한다.
//4. 1번부터 반복한다.

func sumDigit(number: Int) {
    
    var inputNumber = number
    var result = 0
    var subNum = 0
    let index = 10
    var isKeepGo = true
    
    while isKeepGo {
        
        if Double(inputNumber) / Double(index) != 0 {
            subNum = inputNumber % index
            inputNumber -= subNum
            result += subNum
            inputNumber /= 10
        }else{
            
            isKeepGo = false
            
        }
        
    }
    
    print(result)
}

sumDigit(number: 1234)


















