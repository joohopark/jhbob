# Programmers Level 01

## 자리수 연산

### 문제
> sum_digit함수는 자연수를 전달 받아서 숫자의 각 자릿수의 합을 구해서 return합니다.
예를들어 number = 123이면 1 + 2 + 3 = 6을 return하면 됩니다.
sum_digit함수를 완성해보세요.


### 해결
> 입력한 숫자를 한자리씩 때기 위해서는

1. 10씩 증가하는 값으로 입력 값을 반복하여 나눠 1이상이 되는 경우에.
2. 10씩 증가하는 값으로 입력 값의 나머지 연산하여 마지막 값을 떼어내서 결과 변수에 더한다.
3. 입력값- 떼어낸 값으로 변경 한다.
4. 1번부터 반복한다.

<pre>
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
</pre>
