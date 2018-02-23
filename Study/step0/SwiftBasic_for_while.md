# for in, 
# while,
# 반복문,
# 삼항 연산자,
# 논리연산자,
# Function
---
---


## 범위 연산자
- 범위 연산자 

```swift
 1...10 : 1부터 10까지
 1..<10 : 1부터 9 까지
 1...x : x에 변수 올수 있고, 배열등도 올수 있음. 
 
 -> 처음, 끝 지정 숫자에 변수를 넣어도 가능
```


## Swift for in Statement

- 내가 알던 언어 들과 다르게 Swift의 for는 일련의 값의 집합의 원소를 하나씩 꺼내어 반복이 가능.

<pre>
let intList: [Int] = [0,1,2,3,4,5]
var result = 0
for element in intList{

	result += element

}
</pre>

- 기존의 언어 처럼 어떠한 Interval을 통해 반복문을 제어해도 상관이 없다.

<pre>
//let intList: [Int] = [0,1,2,3,4,5]
var result = 0
for index in 0..<10{

	result += index

}
</pre>

- 위의 for in 문에서 index는 반복이 진행될때마다 let으로 선언되어 사용됨.

---
## Swift while Statement

<pre>
let someValue = true
while someValue{

	// someValue가 true일 때만 무한으로 반복

}
</pre>

- 딱히 C, C++ 의 while가 크게 다른 부분이 없다..

## 함수

```
func 함수이름(agument param:type) -> return type{
	return param
}

```

- argument 인수 : 외부에서 함수 호출할때 사용되는 변수 명칭.
- param 매개변수 : 함수 내부에서 사용되는 변수 명칭

## Argument Labels and Parameter Names

- argument는 함수 호출할 때 사용되는 명칭.
- 함수 선언할때 argument를 선언을 생략 할 수 있으나, param의 경우 생략 할 수 없다.
- argument를 생략 했을 때에는 param을 통해 호출해야한다.

## Default Parameter Values

```
func num(num1: Int, num2:Int = 10) -> Int{

	return num1
}

num(num1: 10) // 이런식으로 변수 하나만 해서 호출할 경우에는 num2는 기본 값이 함수호출에 사용된다.

```
- 추가적으로 return type은 생략이 가능하다.

## In-Out Parameter Keyword

```
func swqp(_ a: inout Int, _ b: inout Int){

	let temp = a
	a = b
	b = temp
}

var someInt = 3
var someInt1 = 4
swap(&someInt, &someInt1)
```
- **param은 함수 내부에서 상수 값이다.**
- param을 함수 내부에서 값을 변경 해야 한다면, inout 을 통해 변경 해야한다.. 위의 코드 처럼 함수 내부에서 외부의 값을 변경할때 사용한다.


- inout을 사용하려면 &를 사용하여 위의 처럼 함수 호출에 사용해야함.


  
#### - Inout

- 스위프트는 기본적으로 함수에 들어가는 Parameter 가 함수 내부로 들어가면 해당 파라미터 값을 수정&변경 할수 없음.
- 함수 내부에서 외부의 값에 영향을 주고자 할때 `Inout` 을 사용. 
	- 함수의 { } 밖에서도 사용이 가능

```swift

func Value(li:[Int]) {

		li = [10,20,30,40]
		print(li) 

}
var li:[Int] = [1,2,3,4]

print(Value(li:li)) -> [10,20,30,40]
print(li) -> [1,2,3,4]

값이 변하지 않는다.

func Value(li:Inout [Int]) {

		li = [10,20,30,40]
		print(li) 

}
var li:[Int] = [1,2,3,4]

print(Value(li:&li)) -> [10,20,30,40]
print(li) -> [10,20,30,40]

값이 변해있다. 엄밀하게 위는 Value, 아래는 Reference는 아니지만.. 원리는 비슷하게 동작한다는것을 확인할수 있다.
```
---

## 논리연산자(===, !===)

- '===', '!===' : 같은 인스턴스냐를 비교할때 사용된다. 같은 메모리주소값을 가지고 있다. 같은 참조 형식이다로 이해할수있다.
 
```swift
class Person {
}

var person = Person()
var person2 = person
var person3 = Person()

print(person === person2) // true 
print(person === person3) // false

withUnsafePointer(to: &person) { pA in
    print(pA) }  //0x00000001002fcc10
withUnsafePointer(to: &person2) { pA in
    print(pA) }  //0x00000001002fcc20
withUnsafePointer(to: &person3) { pA in
    print(pA) }  //0x00000001002fcc10
    
- > 같은 인스턴스(내부 properties 와 구성들이 같은) 인지를 비교한다. 서로 다른 메모리 주소를 가지고 있다.
```


---

## 삼항 연산자 

- 문법 <br>
	- question ? answer1 : answer2. -> 조건 <br>  
- 결과 <br>
	- question이 참이면 answer1값을   거짓이면 answer2값은 지정한다. <br>
 
> 삼항 연산자의 응용은, 한줄에 조건값을 적어야 할때 사용하면 유용하게 사용할수 있습니다! 

```swift
let age:Int = 20
var result:String = age > 19 ? "성년" : "미성년" 
   // 변수 안에 결과값과, 조건을 모두 넣었음.. 잘 사용하면 매우 편리하게 사용할수 있을것 같다.
```


##note

```
return의 경우 함수당 1개씩 사용가능.
여러개의 변수를 반환하고자 할경우, tuple이나 다른 컬렉션 타입을 사용하여 넘겨줘야함.
```



##note
<pre>
이중 for in문에서 내부의 반복구문에서 외부의 시퀀스를 증가시킬때 왜 외부 루프가 증가되기 전의 시퀀스만큼만 반복되는걸까?
-> for in 구문은 반복을 진행 하기전 반복구문안에 있는 실행문들을 시퀀스에 맞게 늘어뜨려 놓고 시작 하기때문에 중간에 시퀀스가 증/감 하더라도 반복 횟수는 처음에 정해진 만큼만 진행.
</pre>
