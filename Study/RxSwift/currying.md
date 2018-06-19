# 커링
---

- 하나의 매개변수를 갖는 함수를 통해 여러개의 매개변수를 갖는 함수를 만드는 방법.
	- 함수를 만드는 함수.

``` swift
func 함수를만드는함수(인자: 인자타입) -> ((인자타입) -> 리턴타입)
```

- 왜 커링이라고 불리는건가?

``` swift
// Int형 인자 두개를 받아 덧셈하고 결과를 리턴해주는 함수

func add(_ value1: Int, _ value2: Int) -> Int{
	return value1 + value2
}

add(2,3)

// 커링을 사용한 방법

func curriedAdd(_ value1: Int) -> (Int) -> Int{
	return { value2 in
		return value1 + value2
	}
}

let add2 = curriedAdd(2)

add2(3)// 위의 add와 결과가 같다.
//curriedAdd(2)(3) 동일한 표현이죠..
```

## 예제

- "/" 로 문자열을 파싱
	-"aaa/bbb/ccc/ddd".components(separatedBy: "/")


- "*" 로 문자열을 파싱
	- "aaa/bbb/ccc/ddd".components(separatedBy: "*")

- 만약 프로젝트에서 스트링을 받아서 파싱해야되는 부분이 많다면..?

``` swift
func stringDevider(_ seperater: String) -> (String) -> [String]{
	return { (string: String) -> [String] in
		return string.components(seperaterBy: seperater)
	}
}

let seperSlash = stringDevider("/")
let seperAsterisk = stringDevider("*")

seperSlash("aaa/bbb/ccc/ddd")
seperAsterisk("aaa*bbb*ccc*ddd")

```

## 커링의 또다른 형태

```swift
class SomeClass{
	func someFunctions(){}
}

let someinstance = SomeClass()
someinstance.someFuncsion()

SomeClass.someFunction(someinstance)() // 결과로 someFunctions이 콜됨.
```






