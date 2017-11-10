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

// 문자열을 뒤집기 위해서는
// 1. 문자열을 character 배열로 만든다
// 2. 정렬 함수를 사용하여 character 배열을 정렬한다.

//func reverseStr(str: String){//} -> String.Element {
//
////    var temp: String =  ""
//
//    var inputStr = str
//
////    var listStr = inputStr.sorted()
//
//
//
//    print(listStr)
//
//}
//
//reverseStr(str: "Zbcdefg")

//sum_digit함수는 자연수를 전달 받아서 숫자의 각 자릿수의 합을 구해서 return합니다.
//예를들어 number = 123이면 1 + 2 + 3 = 6을 return하면 됩니다.
//sum_digit함수를 완성해보세요.


// 입력한 숫자를 한자리씩 때기 위해서는
//1. 10씩 증가하는 값으로 입력 값을 반복하여 나눠 1이상이 되는 경우에.
//2. 10씩 증가하는 값으로 입력 값의 나머지 연산하여 마지막 값을 떼어내서 결과 변수에 더한다.
//3. 입력값- 떼어낸 값으로 변경 한다.
//4. 1번부터 반복한다.

//func sumDigit(number: Int) {
//
//    var inputNumber = number
//    var result = 0
//    var subNum = 0
//    let index = 10
//    var isKeepGo = true
//
//    while isKeepGo {
//
//        if Double(inputNumber) / Double(index) != 0 {
//            subNum = inputNumber % index
//            inputNumber -= subNum
//            result += subNum
//            inputNumber /= 10
//        }else{
//
//            isKeepGo = false
//
//        }
//
//    }
//
//    print(result)
//}
//
//sumDigit(number: 1234)



//nextSqaure함수는 정수 n을 매개변수로 입력받습니다.
//n이 임의의 정수 x의 제곱이라면 x+1의 제곱을 리턴하고, n이 임의의 정수 x의 제곱이 아니라면 'no'을 리턴하는 함수를 완성하세요.
//예를들어 n이 121이라면 이는 정수 11의 제곱이므로 (11+1)의 제곱인 144를 리턴하고, 3이라면 'no'을 리턴하면 됩니다.

// 입력값에 대한 제곱근 판별
// 제곱근을 구하는 공식은 -> 증가 값 = (증가 값 + (입력 값/ 증가 값)) / 2
// 증가 값은 0~ 입력 값, 0부터 반복을 시작할경우 divide by zero이므로 1부터 반복

//func nextSqaure(input: Int) -> String{
//
//    var x: Int = 0
//
//    for num in 1...input{
//
//        x = (num + (input/num))/2// 제곱근 구하는 공식
//
//        if input == x*x{
//            return String((x+1)*(x+1))
//        }
//    }
//
//    return "no"
//}
//
//print(nextSqaure(input: 121))



//evenOrOdd 메소드는 int형 num을 매개변수로 받습니다.
//num이 짝수일 경우 "Even"을 반환하고 홀수인 경우 "Odd"를 반환하도록 evenOrOdd에 코드를 작성해 보세요.
//num은 0이상의 정수이며, num이 음수인 경우는 없습니다.

// 짝 홀 구분 하는 함수
// 2로 나머지 연산 했을때 0이면 짝, 아니면 홀


//func evenOrOdd(num: Int) -> String{
//
//    if num % 2 == 0{
//
//        return "Even"
//    }else if num % 2 != 0{
//
//        return "Odd"
//    }
//
//    return ""
//}
//
//print(evenOrOdd(num: 5))



//함수를 완성해서 매개변수 list의 평균값을 return하도록 만들어 보세요.
//어떠한 크기의 list가 와도 평균값을 구할 수 있어야 합니다.


//func average(listInput: [Int]){
//    var result: Int = 0
//
//    for num in listInput{
//
//        result += num
//    }
//
//    print(result/listInput.count)
//}
//average(listInput: [90,80,100])

//피보나치 수는 F(0) = 0, F(1) = 1일 때, 2 이상의 n에 대하여 F(n) = F(n-1) + F(n-2) 가 적용되는 점화식입니다.
//2 이상의 n이 입력되었을 때, fibonacci 함수를 제작하여 n번째 피보나치 수를 반환해 주세요. 예를 들어 n = 3이라면 2를 반환해주면 됩니다.

// 피보나치 수열 0 1 1 2 3 5 8 ....  F(n) = F(n-1) + F(n-2)
// 2 아래인 수는 지정 된 값을 반환
// 2 이상인 수는  F(n) = F(n-1) + F(n-2)를 반환
//func fibo(n: Int) -> Int{
//
//    var result: Int = 0
//    var tmp: Int = 1
//    var current: Int = 0
//
//
//    if n == 1{// 1번째는 값이 0
//        return 0
//    }else if n == 2{// 2번째는 값이 1
//        return 1
//    }else{
//        for _ in 2...n{//3번째부터 tmp를 이전항으로 하고 다음 항을 엘리먼트 + tmp 로 진행, 계산 끝나면 tmp의 값이 변경, 첫 계산은 tmp는 2번째 항의 값을 갖는다.
//            current = result// 결과 항은 현재 항이 된다.
//            result = tmp + current// 이전항과 현재 항을 더한다.
//            tmp = current//현재 항은 이전항이 된다.
//        }
//    }
//    return result
//}
//print("결과:\(fibo(n: 5))")



//printReversedTriangle 메소드는 양의 정수 num을 매개변수로 입력받습니다.
//다음을 참고해 *(별)로 높이가 num인 삼각형을 문자열로 리턴하는 printReversedTriangle 메소드를 완성하세요
//
//높이(num)가 3일때 다음과 같은 문자열을 리턴하면 됩니다.
//***
//**
//*
//func printReversedTriangle(height: Int){
//    let star: String = "*"
//    var printStar: String = ""
//
//    for i in 1...height{
//        for _ in 0...height-i {
//            printStar += star
//        }
//
//        print(printStar)
//        printStar = ""
//    }
//
//}
//printReversedTriangle(height: 3)

//getMiddle메소드는 하나의 단어를 입력 받습니다.
//단어를 입력 받아서 가운데 글자를 반환하도록 getMiddle메소드를 만들어 보세요. 단어의 길이가 짝수일경우 가운데 두글자를 반환하면 됩니다.
//예를들어 입력받은 단어가 power이라면 w를 반환하면 되고, 입력받은 단어가 test라면 es를 반환하면 됩니다.

// Int는 소수점을 버리니 홀수 : count / 2 + 1 을 반환
// 짝수 : count / 2 와 count /2 + 1을 반환
// Swift 4 부터 String은 character의 배열로 표현 가능.
// str.index(str.startIndex, offsetBy: 1) 의 표현 방식으로 String.index 자료형을 얻어 내고
// 문자열에 해당 값으로 접근하면 배열처럼 사용이 가능하다.


//func getMiddle(word: String) -> String{
//
//    var listWord: [Character] = []
//    var indexOfList: String.Index?
//    var resultStr: String = ""
//
//
//    for char in word.characters{
//        listWord.append(char)
//    }
//    if word.count % 2 != 0 {
//        indexOfList = word.index(word.startIndex, offsetBy: word.count/2+1)
//
//        if let _ = indexOfList{
//            return String(word[indexOfList!])
//        }
//
//    }else{
//
//        for index in 0..<2{
//            indexOfList = word.index(word.startIndex, offsetBy: word.count/2+index)
//            resultStr += String(word[indexOfList!])
//        }
//
//        return resultStr
//    }
//
//    return ""
//}
//
//print(getMiddle(word: "ddd"))

//getMinMaxString 메소드는 String형 변수 str을 매개변수로 입력받습니다.
//str에는 공백으로 구분된 숫자들이 저장되어 있습니다.
//str에 나타나는 숫자 중 최소값과 최대값을 찾아 이를 "(최소값) (최대값)"형태의 String을 반환하는 메소드를 완성하세요.
//예를들어 str이 "1 2 3 4"라면 "1 4"를 리턴하고, "-1 -2 -3 -4"라면 "-4 -1"을 리턴하면 됩니다.

// 최소 값을 구하는 반복문과 최대 값을 구하는 반복문을 따로 구현해야될듯?
// " " 공백 문자열을 만날때까지 숫자를 문자열로 만들어 저장. temp1
//" " 공백 문자열을 만날떄까지 숫자를 문자열로 만들어 저장. temp2
// temp1 과 temp2의 값을 비교. 최소 값을 한쪽에 몰고 변수 하나만 값을 계속 검색하여 변경.
// 최소 최대 값 같이 구한 후에 공백 붙여서 리턴.

//자리수가 존재할경우, 부호가 붙어있는 경우도 모두 고려해야함.

//
//func getMinMaxString(str: String){
//
//    var temp1: String = ""
//    var temp2: String = ""
//    //var isNotChange = true
//
//
//}
//
//getMinMaxString(str: "11 12")

//두 수를 입력받아 두 수의 최대공약수와 최소공배수를 반환해주는 gcdlcm 함수를 완성해 보세요.
//배열의 맨 앞에 최대공약수, 그 다음 최소공배수를 넣어 반환하면 됩니다. 예를 들어 gcdlcm(3,12) 가 입력되면, [3, 12]를 반환해주면 됩니다.

//입력으로 두 수 m,n(m>n)이 들어온다.
//n이 0이라면, m을 출력하고 알고리즘을 종료한다.
//m이 n으로 나누어 떨어지면, n을 출력하고 알고리즘을 종료한다.
//그렇지 않으면, m을 n으로 나눈 나머지를 새롭게 m에 대입하고, m과 n을 바꾸고 3번으로 돌아온다.
// 최소 공배수의 경우 아래의 성질을 사용하여 구한다.
//m * n = gcd * gcm
//
//func gcdlcm(fir: Int, sec: Int) -> [Int]{
//
//    var temp = 0
//    var first = fir
//    var second = sec
//    var isKeepGo = true
//    var listResult: [Int] = []
//
//    if first < second{
//
//        temp = second
//        second = first
//        first = temp
//    }// 큰수가 first에 오도록.. first > second
//
//
//    while isKeepGo{
//        if first % second == 0{
//            isKeepGo = false
//            listResult.append(second)
//        }else{
//            first = first % second
//        }
//    }// second는 최대 공약수임...
//
//    //m * n = gcd * gcm
//
//    listResult.append(fir*sec/second)
//
//
//
//    return listResult
//}
//
//print(gcdlcm(fir: 60, sec: 6))

//rm_small함수는 list타입 변수 mylist을 매개변수로 입력받습니다.
//mylist 에서 가장 작은 수를 제거한 리스트를 리턴하고, mylist의 원소가 1개 이하인 경우는 []를 리턴하는 함수를 완성하세요.
//예를들어 mylist가 [4,3,2,1]인 경우는 [4,3,2]를 리턴 하고, [10, 8, 22]면 [10, 22]를 리턴 합니다.
func rmSmall(mylist: Int){
    
    
}

//no_continuous함수는 스트링 s를 매개변수로 입력받습니다.
//
//s의 글자들의 순서를 유지하면서, 글자들 중 연속적으로 나타나는 아이템은 제거된 배열(파이썬은 list)을 리턴하도록 함수를 완성하세요.
//예를들어 다음과 같이 동작하면 됩니다.
//
//s가 '133303'이라면 ['1', '3', '0', '3']를 리턴
//s가 '47330'이라면 [4, 7, 3, 0]을 리턴
func noContinuous(s: String){
    
    
}


//딕셔너리는 들어있는 값에 순서가 없지만, 키를 기준으로 정렬하고 싶습니다. 그래서 키와 값을 튜플로 구성하고, 이를 순서대로 리스트에 넣으려고 합니다.
//예를들어 {"김철수":78, "이하나":97, "정진원":88}이 있다면 각각의 키와 값을
//
//("김철수", 78)
//("이하나", 97)
//("정진원", 88)
//과 같이 튜플로 분리하고 키를 기준으로 정렬해서 다음과 같은 리스트를 만들면 됩니다.
//[ ("김철수", 78), ("이하나", 97), ("정진원", 88) ]
//
//다음 sort_dictionary 함수를 완성해 보세요.
func sortDictionary(){
    
    
}

//alpha_string46함수는 문자열 s를 매개변수로 입력받습니다.
//s의 길이가 4혹은 6이고, 숫자로만 구성되있는지 확인해주는 함수를 완성하세요.
//예를들어 s가 "a234"이면 False를 리턴하고 "1234"라면 True를 리턴하면 됩니다

// 길이를 먼저 체크한다.
// 길이 체크 후, Int로 형변환, 형변환 실패시 알파벳이 포함된 문자열임.
//func alphaString46(s: String) -> String{
//
//    var checkInt: String = ""
//
//    if s.count == 4 || s.count == 6{
//
//        for char in s{
//            checkInt.append(char)
//        }
//
//    }else{
//        return "False"
//    }
//
//    if let _ = Int(checkInt){
//        return "True"
//    }
//    return "False"
//}
//
//print(alphaString46(s: "a234"))

//어떤 수를 입력받아 그 수의 약수를 모두 더한 수 sumDivisor 함수를 완성해 보세요.
//예를 들어 12가 입력된다면 12의 약수는 [1, 2, 3, 4, 6, 12]가 되고, 총 합은 28이 되므로 28을 반환해 주면 됩니다.
func sumDivisor(num: Int){
    
    
}

//numPY함수는 대문자와 소문자가 섞여있는 문자열 s를 매개변수로 입력받습니다.
//s에 'p'의 개수와 'y'의 개수를 비교해 같으면 True, 다르면 False를 리턴하도록 함수를 완성하세요.
//'p', 'y' 모두 하나도 없는 경우는 항상 True를 리턴합니다.
//예를들어 s가 "pPoooyY"면 True를 리턴하고 "Pyy"라면 False를 리턴합니다.
func numPY(){
    
    
}


//divisible 메소드는 int형 배열 array와 int divisor를 매개변수로 받습니다.
//array의 각 element 중 divisor로 나누어 떨어지는 값만 포함하는 새로운 배열을 만들어서 반환하도록 divisible에 코드를 작성해 보세요.
//
//예를들어 array가 {5, 9, 7, 10}이고 divisor가 5이면 {5, 10}을 리턴해야 합니다.
func divisible(array: [Int], divisor: Int){
    
    
}


//number_generator함수는 x와 n을 입력 받습니다.
//2와 5를 입력 받으면 2부터 시작해서 2씩 증가하는 숫자를 5개 가지는 리스트를 만들어서 리턴합니다.
//[2,4,6,8,10]
//
//4와 3을 입력 받으면 4부터 시작해서 4씩 증가하는 숫자를 3개 가지는 리스트를 만들어서 리턴합니다.
//[4,8,12]
//
//이를 일반화 하면 x부터 시작해서 x씩 증가하는 숫자를 n개 가지는 리스트를 리턴하도록 함수 number_generator를 완성하면 됩니다
//func numberGenerator(x: Int, n: Int){
//
//    var inputX = x
//    var listResult:[Int] = []
//
//    for _ in 0..<n{
//        listResult.append(inputX)
//        inputX += inputX
//    }
//
//    print(listResult)
//}
//
//numberGenerator(x: 2, n: 5)

//strange_sort함수는 strings와 n이라는 매개변수를 받아들입니다.
//strings는 문자열로 구성된 리스트인데, 각 문자열을 인덱스 n인 글자를 기준으로 정렬하면 됩니다.
//
//예를들어 strings가 ["sun", "bed", "car"]이고 n이 1이면 각 단어의 인덱스 1인 문자 u, e ,a를 기준으로 정렬해야 하므로 결과는 ["car", "bed", "sun"]이 됩니다.
//strange_sort함수를 완성해 보세요.
func strangeSort(strings: String, n: Int){
    
    
}


