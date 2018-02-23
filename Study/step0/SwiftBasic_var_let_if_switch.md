# Swift 변수 정의, 
# 자료형, 
# 산술 & 비교 & 논리 연산자,
# 타입추론, 
# Condition Syntax(If, Guard, Switch)
--- 
---

## 변수 & 함수
 - 변수 : 메모리에 값 할당. 언어 마다(객체지향, 순서지향) 저장되는 방식이 조금씩 차이가 있음
 - 힘수 : 변수와 구문들의 코드가 모인 블럭(스텍프레임의 방식으로 함수 호출시, 변수가 쌓이고, 함수 끝나면 메모리 해제됨)
 
## 변수, 상수 선언.
- 변수, 상수는 프로그램 코드 안에서 값을 저장하기 위한 용도로 사용한다.
- 변수와 상수는 사용되기 전에 어떠한 자료형의 값을 저장할지, 어떤 값을 대입할지를 결정 후 선언을 해야함.
<pre>
var 변수: 자료형 = 대입할 값
let 상수: 자료형 = 대입할 값
</pre>

	- 자료형의 경우 명시를 하지 않아도, 대입할 값을 통해 자료형의 추론이 가능하다.( 자료형은 생략해도됨)
	- 복잡하게 이야기 했지만 결국 초기화 해서 써야된다는 이야기임.

--- 
## 명명 규칙

- 유니코드 문자 포함한 모든 문자 표현 가능
<pre>
<code>
//syntax
var strA: String = "문자열 변수 선언"
var 문자열: String = "한글로도 표현이 가능, 바람직 하진 않다"
</code>
</pre>

- 변수의 이름은 저장할 데이터를 이해할 수 있도록 해야함. ( 가독성을 위해서..)
- 한 블록 ( { } ) 안에서 중복으로 선언하여 사용 할 수 없다.
- 시스템 예약어는 사용할 수 없음.

--- 
## var vs let

- var는 선언 및 초기화 이후 변경이 가능한 값으로 흔히들 변수라고 명함.
- let은 선언 및 초기화 이후 변경이 불가능한 값으로 흔히들 상수라고 명함.

<pre><code>
var 변수: Int = 3
변수 = 4 // 가능

let 상수: Int = 4
상수 = 3// 불가능.
</code></pre>

--- 
## 변수 자료형

- Int(정수) : 1,2,3,10.. ex) var intName:Int
- Double(실수) : 1.1, 2.34, 3.2 ex) doubleName:Double <br>
- String(문자열) : "yo man~!" ex) var stringName:String
	- swift에서는 문자열을 character의 배열로 보지 않았는데 swift4부터 배열로 처리가 가능해졌다.
- Bool(불리언) : true or false ex) var boolName:Bool 
- Character : 단어나 문장이 아닌 문자 하나

--- 
## Int & Uint

- 정수형 타입(integer)
- Int : +/- 부호를 포함한 정수이다. 
- Uint : -부호를 포함하지 않은(0은 포함) 정수
- 최대값과 최소값은 max, min 프로퍼티를 통해 알아볼수 있다.
- 8, 16, 32, 64의 시스템 아키텍쳐에 따라서 달라진다. 인코딩 방식에 따라서 아스키, 유니코드을 선택을 하는게 달라진다는 이야기 같음..(정확하게 이해x)

---
## 산술 연산자 & 비교 연산자 & 논리 연산자 

- 산술 연산자 : `> +, -, *, /, % (더하기, 빼기, 곱하기, 나누기, 나머지)`
- 비교 연산자 : `> ==, >=, <=, >, <, (값이 같다, 크거나 같다ㅡ 작거나 같다, 크다, 작다)`
- 논리 연산자 : `> &&, ||, ! (AND, OR, NOT)`

---
## If, Guard, Switch

---
### Swift if statement

<pre>
let condition: Int = 1
if condition == 1{
	
	// 조건이 참일경우 실행
}else if condition > 1{

	// 조건이 참일경우 실행
}else{

	// 위의 조건들이 모두 거짓일경우 실행
	
}
</pre>

- 사실상 다른언어의 if 문법과 다를것이 없다. 

---
### Swift guard statement

<pre>
let someValue = 1
guard someValue > 0 else{

	// guard의 조건이 참이 아닐경우.
}
// 참이면 guard 문 다음 로직을 진행.
</pre>

- if 문의 반대개념이다. 
- 특정 조건을 만족하지 않을때 보통 return 하게 만들어 사용 한다.
- 옵셔널 바인딩에서 주로 사용...

---
### Swift Switch statement

<pre>
let someValue = "2"
Switch someValue{

	case "1":
		//someValue가 "1"일 경우.
	case "2",
	case "3":
		//someValue가 "2" 또는 "3"일 경우
	default:
		// case의 경우가 모두 아닐 경우.
}
</pre>

- 패턴 비교문으로 해당 값의 일정 패턴일 경우 해야 하는 로직을 수행하도록 구현한다.
- 패턴이 갖을 수 있는 모든 경우를 표현 할 수 없다면 default는 필수!

### Interval Matching

- Swift의 Switch는 단순 패턴 비교가아닌, 패턴에 구간을 설정하여 case 구성이 가능
	- 써보면 매우 편리...
<pre>
let someValue = 4

Switch someValue{

	case 0:
		// 0일떼
	case 1..<5:
		// 1 <= 5 일때
	case 5..<10:
		// 5 <= 10 일때
	default:
		// case 이외 범위일때.

}
</pre>

---
### Switch Statement using Tuple

- Swift의 Tuple을 case 조건으로 활용하여 여러 값을 동시에 체크 할 수 있음.
	- 와일드 카드(_) 를 통해서 특정 조건만 만족할 경우 로직 수행을 하도록 구현 가능.

<pre>
let hugak = ("허각", "혼자 한잔")
Switch hugak{

	case ("허각", "죽고싶단 말 밖에"):
	
	case("허각", "혼자 한잔"):
	
	case("허각", _ ):
	
	case ( _ , "Hello"):
	
	default:

}

</pre>

---
### Value Binding in Switch Statement

- Switch 문 내부에서 사용된 값을 임시로 사용할 수 있음.

<pre>
let someTuple = (1, 3)

Switch someTuple{
	
	case (1, let a):
		print(a)
	case (let b, 3)"
		print(b)
	case (0..<3, 2..<4):
	default:

}

</pre>

- 위의 Switch처럼 복잡시레 짤 수 도 있다. 라인 수를 많이 줄일 수 있는 방법일듯..

---
### add where condition in Switch Statement

- where 절을 넣어 특정 조건을 만족 시킬 경우, 진행 되도록 할 수 있다..

<pre>
let someTuple = (a, b)

Switch someTuple{

	case (a ,b) where a > b:
	case (a, b) where a < b:
	default:

}

</pre>




---
### note
<pre>
타입추론?
Swift 에서는 변수 선언시 할당하는 값에 따라 타입을 추론하여 가질 수있다.(무조건 선언시 타입을 명시 하지 않아도 된다.)
C, C++ 에서 Int numA = 0과 같이 선언시 앞에 자료형을 무조건 적어주던것과 차이가있음.
</pre>


--- 
## Reference

[Swift Programming Guide](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html)

