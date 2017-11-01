#Recursive Think

> 재귀적으로 프로그램을 생각하기..

- 재귀는 수함 점화식 표현에만 특화된것이 아니라 다른 알고리즘의 표현에도 사용이 가능해여...

```
저번 정리에서 반복문으로 표현하는것은 재귀로 표현이 가능하다 했었다.
이번 정리에서는 반복문과 재귀의 사고의 차이에 대하여 정리하도록 하겠음..!!
```


|      | 절차적 사고                                 | Recursive Think                                                                      |
|------|---------------------------------------------|--------------------------------------------------------------------------------------|
| 특징 | - 순차적으로 문제를 생각하여 결론을 내린다. | - Recursive Case에서 BaseCase로 수렴할때의 그 마지막 부터 문제를 풀어 결론을 내린다. |

## 예시 1. 문자열 길이 계산.

![]()

- 절차적 사고 : 문자를 하나씩 센다.(for, while을 사용.)
- Recursive Think : 두번째 문자부터 끝의 문자까지의 길이에 + 1(여기서 BaseCase는 첫번째 문자열을 재거한 이후(문자열 길이 - 1) + 1이라고 표현 할 수 없는 문자열 길이 0일때가 되겠음..)

<pre>
var Str: String = "angel"
func checkStringSize(str: String) -> Int{

    if str == ""{
            return 0
    }// Base Case
    
    var remeveStrZeroIndex = str.index(str.startIndex, offsetBy: 1)
    
    let subStr = str[remeveStrZeroIndex...]
    return 1+checkStringSize(str: String(subStr))
    
}

print(checkStringSize(str: Str))
</pre>

- 물론 cocoatouch에서 지원하는 문자열 계산 함수가 있겠지만 굳이 만들어본다면 위와 같게 만들어질것이다.
	- Swift4부터? 는 String도 character배열로 이루어지며, 이를 배열로 표현하기위해서는 String.Index라는 자료형을 사용해야한다.
	- String.Index로 표현한 문자열 배열 Index는 SubString이기 때문에 String과 다른 자료형식으로 사용된다.( 이를 위해 Casting이 필요하다.)



## 예제 2. 2진수 변환 출력
- 절차적 사고
	- 반복적으로 2로 나눠 떨어지면 0 아니면 1을 String으로 변환하여 더해주고, 결과값을 뒤집어 출력. 
	
- 재귀적 사고
 - base: n<2보다 작을때 더 이상 못 나누므로 끝내도록 함.
 - recusive : 2로 나눈 몫을 출력하고 마지막에 2로 나눈 나머지를 출력.
	
<pre>
func decimalToBinary(decimal: Int){
    
    if decimal < 2{
        print("BaseCase            \(decimal)")
    }else{
    decimalToBinary(decimal: decimal/2)
    print("RecursionCase  \(decimal%2)")
    }
    
}

decimalToBinary(decimal: 10)
</pre>

- 핵심은 먼저 베이스 케이스를 정하고, 반복의 마지막 을 정하고 재귀를 돌도록 한다.
- 경험상 재귀로 들어가는 부분(BaseCase로 수렴하는 부분)과 연산이 있는 부분을 조건으로 생각하고 짜면 쉽게 풀릴것 같다.. 쉬운 문제들은..

- 모든 재귀는 반복으로 표현이 가능, 그 역도 성립
- 복잡한 알고리즘을 단순화 시키는데 최적화. 가시성도 좋다.
- 함수 스택에 따른 오버헤드가 존재, 파라미터 전달
