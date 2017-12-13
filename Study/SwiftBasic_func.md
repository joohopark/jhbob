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


##note

```
return의 경우 함수당 1개씩 사용가능.
여러개의 변수를 반환하고자 할경우, tuple이나 다른 컬렉션 타입을 사용하여 넘겨줘야함.
```

