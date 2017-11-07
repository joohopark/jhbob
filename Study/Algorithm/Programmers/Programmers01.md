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

## 제곱근 판별

### 문제
> nextSqaure함수는 정수 n을 매개변수로 입력받습니다.


>n이 임의의 정수 x의 제곱이라면 x+1의 제곱을 리턴하고, n이 임의의 정수 x의 제곱이 아니라면 'no'을 리턴하는 함수를 완성하세요.


>예를들어 n이 121이라면 이는 정수 11의 제곱이므로 (11+1)의 제곱인 144를 리턴하고, 3이라면 'no'을 리턴하면 됩니다.

### 해결
> 입력값에 대한 제곱근 판별

```
 제곱근을 구하는 공식은 -> 증가 값 = (증가 값 + (입력 값/ 증가 값)) / 2
 증가 값은 0~ 입력 값, 0부터 반복을 시작할경우 divide by zero이므로 1부터 반복
```



<pre>
func nextSqaure(input: Int) -> String{

    var x: Int = 0
    
    for num in 1...input{
        
        x = (num + (input/num))/2// 제곱근 구하는 공식
        
        if input == x*x{
            return String((x+1)*(x+1))
        }
    }
    
    return "no"
}

print(nextSqaure(input: 121))
</pre>


## 짝, 홀 구분

### 문제

> evenOrOdd 메소드는 int형 num을 매개변수로 받습니다.

> num이 짝수일 경우 "Even"을 반환하고 홀수인 경우 "Odd"를 반환하도록 evenOrOdd에 코드를 작성해 보세요.

> num은 0이상의 정수이며, num이 음수인 경우는 없습니다.

### 해결
> 짝 홀 구분 하는 함수
<pre>
2로 나머지 연산 했을때 0이면 짝, 아니면 홀
</pre>


```
func evenOrOdd(num: Int) -> String{
    
    if num % 2 == 0{
        
        return "Even"
    }else if num % 2 != 0{
        
        return "Odd"
    }
    
    return ""
}

print(evenOrOdd(num: 5))
```


